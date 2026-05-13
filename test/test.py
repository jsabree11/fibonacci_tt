import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, ClockCycles


@cocotb.test()
async def test_fibonacci_checker(dut):
    cocotb.start_soon(Clock(dut.clk, 10, unit="ns").start())

    dut.ena.value = 1
    dut.uio_in.value = 0
    dut.ui_in.value = 0

    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 3)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 3)

    fib_values = [0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]
    non_fib = [4, 6, 7, 9, 10, 12, 22, 100, 200]

    for value in fib_values:
        dut.ui_in.value = value
        dut.rst_n.value = 0
        await ClockCycles(dut.clk, 2)
        dut.rst_n.value = 1

        await ClockCycles(dut.clk, 20)

        result = int(dut.uo_out.value) & 1
        assert result == 1, f"{value} should be Fibonacci"

    for value in non_fib:
        dut.ui_in.value = value
        dut.rst_n.value = 0
        await ClockCycles(dut.clk, 2)
        dut.rst_n.value = 1

        await ClockCycles(dut.clk, 20)

        result = int(dut.uo_out.value) & 1
        assert result == 0, f"{value} should NOT be Fibonacci"
