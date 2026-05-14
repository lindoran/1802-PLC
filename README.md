# RCA CDP1802 PLC / Test Fixture Board

This repository is an initial capture of an RCA CDP1802-based controller board.
The board appears to be a small PLC-like or test-fixture controller built around:

- RCA `CDP1802` CPU
- `D2716` 2 KB parallel EPROM, labeled `Test Fixture R1.7`
- Five RCA `CDP1852CE` parallel I/O ICs visible in the board photo
- CMOS glue logic and counters/latches such as CD4040, CD4042, CD4078, CD4081,
  CD4011, CD4049, and related parts
- Transformer/power section plus multiple card-edge/header connections

The short version: this looks like a dedicated 1802 controller with several
8-bit parallel ports. The ROM is small, mostly program plus a large table/text
area, and the I/O-heavy instruction mix strongly suggests it is driving and/or
reading fixture wiring rather than running a general-purpose monitor.

## Repository Contents

- `1802.jpg` - photo of the controller board
- `ROM/D2716-ROM-lable-First-Fixture-R1.7.BIN` - raw 2048-byte EPROM dump
- `ROM/D2716-ROM-lable-First-Fixture-R1.7.HEX` - Intel HEX version of the ROM
- `ROM/src/D2716-ROM-R1_7.asm` - current generated 1802 disassembly
- `ROM/src/disasm1802.c` - local CDP1802 disassembler used to produce the asm
- `doc/RCA1802-Instruction-Set.pdf` - 1802 opcode reference
- `doc/1802sum.pdf` - short 1802 quick-reference page

## ROM Inventory

EPROM dump:

- Device size: 2048 bytes, consistent with a 2716 EPROM
- Address range: `0x0000` through `0x07FF`
- Programmed data appears to run through about `0x059E`
- `0x059F` through `0x07FF` is erased/unprogrammed `0xFF`
- SHA-256 of binary dump:
  `bb8292bfbc4ef429407069c84562e4188a7f2d3a863d9a8a84201bddadf031f3`

The ROM starts with executable-looking CDP1802 code at `0x0000`. Later in the
image, roughly from the `0x01CA` area onward, there is a large region containing
printable bytes, spaces, separators, and short non-printable markers. That area
is probably data: labels, test-step text, encoded I/O descriptions, or a fixture
table.

## Hardware Notes From Photo

Visible major parts:

- `RCA CDP1802D` CPU
- `D2716` EPROM with handwritten label: `Test Fixture R1.7`
- Five `RCA CDP1852CE` parallel I/O parts
- Multiple RCA CMOS support chips including parts marked like `CD4040AE`,
  `CD4042AE`, `CD4078AE`, `CD4081AE`, `CD4049AE`, and `CD4011`
- Additional small ICs on the right side near the I/O headers

The five CDP1852 chips are the biggest clue. CDP1852 is an 8-bit parallel I/O
port/latch device for 1800-family systems, so this board likely exposes a large
number of fixture signals. With five of them, the machine could have up to about
40 parallel I/O bits before accounting for direction, strobes, and board-level
logic.

## Preliminary Firmware Reading

The early code uses many 1802 I/O and control-flow instructions:

- `OUT 1`, `OUT 2`, `OUT 3`, `OUT 4`, `OUT 5`
- `B1` / `BN1`, so external flag input `EF1` matters
- `SEQ`, which drives the 1802 `Q` output
- Many `SEP Rx` instructions, which is normal 1802 style for subroutine/threaded
  control flow

Initial constants and repeated setup patterns suggest the firmware is arranging
registers as pointers into RAM/ROM and then using the 1802 I/O opcodes to strobe
external ports. The visible use of `OUT 1` through `OUT 5` lines up well with the
five CDP1852 devices.

The ROM label says `First Fixture R1.7`, so the current best guess is:

> A custom production/test fixture controller, not a generic PLC product.

It may still behave PLC-like, because the hardware is a CPU plus parallel input
and output banks, but the ROM content looks application-specific.

## Disassembly Caution

The current `ROM/src/D2716-ROM-R1_7.asm` is useful as a first pass, but should
not be treated as final annotated source.

The disassembler has a heuristic that emits any run of four printable bytes as
`.ASCII`. That is too aggressive for 1802 code because valid instruction bytes
can also be printable ASCII. For example, byte sequences like:

```text
61 62 30 4E
61 62 30 5C
```

can be real code:

```asm
OUT 1
OUT 2
BR  0x014E / 0x015C
```

but the current disassembly can label them as strings such as `"ab0N"` or
`"ab0\"`.

So the next analysis pass should use a raw decode or a control-flow-aware
disassembler, then mark data only after reachable code paths are understood.

## Current Working Theory

Known:

- This is a CDP1802 embedded controller.
- The ROM image is a valid 2 KB D2716-sized dump.
- The board contains five CDP1852 parallel I/O ICs.
- The firmware uses CDP1802 I/O opcodes for ports 1 through 5.
- The EPROM label identifies it as `Test Fixture R1.7`.

Likely:

- The CDP1852 devices are mapped to the 1802 `OUT`/`INP` port space.
- The board drives and senses external fixture pins through the headers/edge
  connectors.
- The printable ROM region contains fixture-specific tables, signal names,
  prompts, expected states, or compressed test definitions.

Unknown:

- Exact CDP1852 port addresses and signal names
- Whether each CDP1852 is configured as input, output, or mixed through board
  logic
- RAM size and address map
- Meaning of the large table area
- Power/interface pinout for the edge connectors

## Suggested Next Steps

1. Redo the disassembly without automatic ASCII detection.
2. Build a reachable-code map from reset at `0x0000`.
3. Identify all `OUT n`, `INP n`, `EF1`-`EF4`, and `Q` uses.
4. Trace the five CDP1852 chip selects from the board to map ports 1-5.
5. Decode the table region starting around `0x01CA`.
6. Photograph or scan the back of the board so the address decode and I/O wiring
   can be traced.
7. If possible, dump any RAM/IO behavior on a powered board with a logic analyzer.

## Rebuilding The Current Disassembly

The provided disassembler builds cleanly with:

```sh
cc -Wall -Wextra -o /tmp/disasm1802 ROM/src/disasm1802.c
```

Current generated assembly can be regenerated with:

```sh
/tmp/disasm1802 ROM/D2716-ROM-lable-First-Fixture-R1.7.BIN > ROM/src/D2716-ROM-R1_7.asm
```

For deeper reverse engineering, first change or bypass the ASCII heuristic so
that executable-looking byte runs are not hidden as `.ASCII`.
