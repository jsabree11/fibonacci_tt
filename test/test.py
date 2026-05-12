import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_fibonacci_checker(dut):

    fib_values = [0,1,2,3,5,8,13,21,34,55,89,144,233]

    for value in fib_values:
        dut.ui_in.value = value
        await Timer(1, unit="ns")

        assert (int(dut.uo_out.value) & 1) == 1

    non_fib = [4,6,7,9,10,12]

    for value in non_fib:
        dut.ui_in.value = value
        await Timer(1, unit="ns")

        assert (int(dut.uo_out.value) & 1) == 0
