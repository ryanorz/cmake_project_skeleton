#define CATCH_CONFIG_MAIN
#include <catch.hpp>

TEST_CASE("example suite", "[example]")
{
    REQUIRE((1+1) == 2);
}

