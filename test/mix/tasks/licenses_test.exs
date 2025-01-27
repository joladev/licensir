defmodule Licensir.Mix.Tasks.LicensesTest do
  use Licensir.Case
  import ExUnit.CaptureIO

  test "prints a list of dependencies and their licenses" do
    output =
      capture_io(fn ->
        Mix.Tasks.Licenses.run([])
      end)

    expected =
      IO.ANSI.format_fragment([
        [:yellow, "Notice: This is not a legal advice. Use the information below at your own risk."], :reset, "\n",
        "+-----------------------------------+---------+----------------------------------------------------+", "\n",
        "| Package                           | Version | License                                            |", "\n",
        "+-----------------------------------+---------+----------------------------------------------------+", "\n",
        "| dep_license_undefined             |         | Undefined                                          |", "\n",
        "| dep_of_dep                        |         | Undefined                                          |", "\n",
        "| dep_one_license                   |         | Licensir Mock License                              |", "\n",
        "| dep_one_unrecognized_license_file |         | Unrecognized license file content                  |", "\n",
        "| dep_two_conflicting_licenses      |         | Unsure (found: License One, Licensir Mock License) |", "\n",
        "| dep_two_licenses                  |         | License Two, License Three                         |", "\n",
        "| dep_two_variants_same_license     |         | Apache 2.0                                         |", "\n",
        "| dep_with_dep                      |         | Undefined                                          |", "\n",
        "+-----------------------------------+---------+----------------------------------------------------+", "\n", "\n"
      ])
      |> to_string()

    assert output == expected
  end
end
