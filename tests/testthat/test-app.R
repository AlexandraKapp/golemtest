test_that("multiplication works", {
  expect_equal(2 * 2, 5)
})

test_that("one plus one is two", {
  expect_equal(oneplusone(), 2)
})

test_that("one plus one is length 1", {
  expect_length(oneplusone(), 1)
})

test_that("one plus one is two", {
  expect_true(oneplusone() == 2)
})


test_that("one plus one is two", {
  expect(oneplusone() == 2, "calling one plus one does not return 2")
})