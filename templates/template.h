#pragma once // Only called once
#include <iostream>

// Templates
// These must be implimented in the header file
/**
 * @brief Prints the raw value of the input.
 * @param val Value to print.
 */
template <typename T>
void print_value(T val)
{
  try
  {
    std::cout << "Raw val: " << val << std::endl;
  }
  catch (const std::exception& e)
  {
    std::cout << "Exeception was thrown: " << e.what() << std::endl;
  }
}

/**
 * @brief Prints given string.
 * @param str Value to print.
 */
void print_value(const char* str);

// Regular functions
/**
 * @brief Adds two numbers together.
 *
 * This function just adds two int values together and returns.
 * This function has a sense of humor.
 *
 * @param a Value 1.
 * @param b Value 2.
 * @return The result of a + b if a + b != 69. If a + b == 69, return 420.
 * @note If the result is 69, the function finds it funny and returns 420 instead.
 */
int add(int a, int b);
