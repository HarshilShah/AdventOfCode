//: [Previous](@previous)
import Foundation

let input = """
[1518-05-30 00:04] Guard #2417 begins shift
[1518-10-20 00:48] wakes up
[1518-08-12 00:14] falls asleep
[1518-05-09 23:54] Guard #2969 begins shift
[1518-07-28 00:14] falls asleep
[1518-09-06 23:57] Guard #797 begins shift
[1518-05-14 00:54] wakes up
[1518-08-24 00:45] falls asleep
[1518-09-26 00:47] falls asleep
[1518-02-18 23:58] Guard #521 begins shift
[1518-06-15 00:58] wakes up
[1518-03-02 00:19] falls asleep
[1518-03-21 00:00] Guard #521 begins shift
[1518-02-26 00:40] wakes up
[1518-04-10 00:01] Guard #479 begins shift
[1518-05-20 00:42] wakes up
[1518-05-25 00:11] falls asleep
[1518-11-03 00:31] falls asleep
[1518-08-11 00:47] falls asleep
[1518-06-23 23:58] Guard #829 begins shift
[1518-04-07 00:39] wakes up
[1518-07-11 00:03] Guard #2027 begins shift
[1518-07-16 00:43] falls asleep
[1518-10-25 00:45] falls asleep
[1518-10-13 00:04] Guard #1621 begins shift
[1518-08-09 00:00] Guard #2741 begins shift
[1518-10-24 00:32] falls asleep
[1518-02-27 00:03] Guard #479 begins shift
[1518-02-22 00:00] Guard #797 begins shift
[1518-09-28 00:00] Guard #2417 begins shift
[1518-02-27 00:55] wakes up
[1518-07-18 00:01] Guard #349 begins shift
[1518-08-03 00:38] falls asleep
[1518-10-06 00:52] wakes up
[1518-04-19 00:56] wakes up
[1518-09-27 00:35] wakes up
[1518-09-13 00:39] wakes up
[1518-08-10 00:58] wakes up
[1518-03-01 00:00] Guard #797 begins shift
[1518-07-31 00:32] falls asleep
[1518-05-31 00:35] wakes up
[1518-10-04 00:04] Guard #2969 begins shift
[1518-02-21 00:19] wakes up
[1518-11-04 00:57] falls asleep
[1518-05-09 00:12] falls asleep
[1518-06-21 00:03] Guard #521 begins shift
[1518-05-28 00:44] wakes up
[1518-11-04 00:58] wakes up
[1518-05-20 00:01] Guard #521 begins shift
[1518-04-05 23:58] Guard #2741 begins shift
[1518-07-17 00:45] falls asleep
[1518-04-15 00:53] wakes up
[1518-10-03 00:37] falls asleep
[1518-04-21 23:57] Guard #1129 begins shift
[1518-03-10 00:56] wakes up
[1518-04-08 00:26] wakes up
[1518-10-09 00:29] wakes up
[1518-03-17 00:58] wakes up
[1518-04-17 00:03] Guard #2969 begins shift
[1518-07-08 00:27] falls asleep
[1518-03-23 00:19] wakes up
[1518-04-17 00:43] wakes up
[1518-06-13 00:49] falls asleep
[1518-06-15 00:47] falls asleep
[1518-05-25 00:53] wakes up
[1518-07-26 00:56] wakes up
[1518-03-19 00:53] wakes up
[1518-05-16 00:03] falls asleep
[1518-03-19 00:03] Guard #349 begins shift
[1518-11-22 23:48] Guard #797 begins shift
[1518-08-26 00:57] wakes up
[1518-11-04 00:04] Guard #829 begins shift
[1518-11-03 00:59] wakes up
[1518-06-25 00:02] Guard #829 begins shift
[1518-10-31 00:55] wakes up
[1518-05-02 00:22] falls asleep
[1518-11-17 00:26] wakes up
[1518-05-02 00:50] wakes up
[1518-10-21 00:42] wakes up
[1518-06-19 00:16] falls asleep
[1518-08-08 00:58] wakes up
[1518-05-04 00:26] falls asleep
[1518-11-19 00:11] falls asleep
[1518-07-02 00:56] wakes up
[1518-02-28 00:20] falls asleep
[1518-11-10 00:03] Guard #2473 begins shift
[1518-09-23 00:55] wakes up
[1518-07-22 00:51] wakes up
[1518-04-14 00:34] wakes up
[1518-03-23 00:56] falls asleep
[1518-04-26 00:31] falls asleep
[1518-06-05 00:25] falls asleep
[1518-03-27 00:05] falls asleep
[1518-03-09 00:00] Guard #349 begins shift
[1518-07-25 00:02] falls asleep
[1518-08-12 00:59] wakes up
[1518-04-04 00:50] wakes up
[1518-03-12 00:19] falls asleep
[1518-09-10 00:00] Guard #2699 begins shift
[1518-07-01 23:59] Guard #2741 begins shift
[1518-11-09 00:14] wakes up
[1518-09-02 00:11] falls asleep
[1518-04-07 00:00] Guard #67 begins shift
[1518-06-10 00:24] falls asleep
[1518-08-30 00:37] falls asleep
[1518-09-12 00:05] falls asleep
[1518-05-08 00:57] wakes up
[1518-10-15 00:13] falls asleep
[1518-03-28 23:58] Guard #2741 begins shift
[1518-09-20 00:40] falls asleep
[1518-10-07 00:13] falls asleep
[1518-05-03 00:41] falls asleep
[1518-09-28 23:56] Guard #1301 begins shift
[1518-05-15 00:59] wakes up
[1518-10-03 00:53] wakes up
[1518-07-28 00:54] falls asleep
[1518-04-08 23:58] Guard #1129 begins shift
[1518-06-08 00:01] Guard #2027 begins shift
[1518-07-28 23:50] Guard #797 begins shift
[1518-09-20 00:04] falls asleep
[1518-10-02 00:26] wakes up
[1518-07-02 23:46] Guard #797 begins shift
[1518-07-18 00:59] wakes up
[1518-07-22 00:54] falls asleep
[1518-08-03 00:53] wakes up
[1518-10-28 00:23] falls asleep
[1518-04-12 00:47] falls asleep
[1518-11-06 00:55] wakes up
[1518-08-11 00:49] wakes up
[1518-09-18 00:39] wakes up
[1518-03-29 00:55] wakes up
[1518-06-27 00:59] wakes up
[1518-06-22 00:36] wakes up
[1518-05-14 00:35] falls asleep
[1518-09-22 00:55] falls asleep
[1518-10-30 00:09] wakes up
[1518-08-06 00:47] wakes up
[1518-07-14 00:35] wakes up
[1518-11-03 00:49] falls asleep
[1518-09-03 00:48] wakes up
[1518-03-28 00:11] wakes up
[1518-04-17 00:25] falls asleep
[1518-05-04 00:02] Guard #2027 begins shift
[1518-11-22 00:22] falls asleep
[1518-09-13 00:23] wakes up
[1518-11-21 00:52] falls asleep
[1518-04-21 00:29] wakes up
[1518-07-06 23:57] Guard #2027 begins shift
[1518-04-22 00:47] wakes up
[1518-06-14 00:38] falls asleep
[1518-04-25 00:08] falls asleep
[1518-08-28 23:59] Guard #349 begins shift
[1518-05-08 23:56] Guard #1301 begins shift
[1518-10-25 00:15] falls asleep
[1518-02-26 00:51] falls asleep
[1518-11-09 00:01] Guard #479 begins shift
[1518-06-13 00:10] wakes up
[1518-08-18 00:16] falls asleep
[1518-03-24 00:54] wakes up
[1518-07-27 00:35] falls asleep
[1518-06-25 00:47] wakes up
[1518-05-15 23:54] Guard #229 begins shift
[1518-09-08 00:49] wakes up
[1518-07-26 00:23] falls asleep
[1518-09-15 00:28] falls asleep
[1518-08-17 00:35] falls asleep
[1518-05-16 23:49] Guard #3067 begins shift
[1518-08-03 00:04] Guard #2969 begins shift
[1518-09-02 00:28] wakes up
[1518-04-12 00:22] wakes up
[1518-05-20 00:28] wakes up
[1518-10-19 00:19] falls asleep
[1518-05-30 00:07] falls asleep
[1518-07-10 00:33] wakes up
[1518-10-01 23:57] Guard #2741 begins shift
[1518-05-18 00:04] Guard #521 begins shift
[1518-05-05 00:44] falls asleep
[1518-03-24 00:02] Guard #1129 begins shift
[1518-03-28 00:47] wakes up
[1518-07-27 00:36] wakes up
[1518-10-25 23:50] Guard #2473 begins shift
[1518-11-17 00:41] falls asleep
[1518-06-05 00:00] Guard #3067 begins shift
[1518-07-14 00:46] falls asleep
[1518-09-18 00:05] falls asleep
[1518-11-23 00:32] falls asleep
[1518-06-22 00:40] wakes up
[1518-11-11 00:00] Guard #2699 begins shift
[1518-03-02 00:03] Guard #2417 begins shift
[1518-03-05 23:58] Guard #349 begins shift
[1518-03-16 00:00] Guard #2473 begins shift
[1518-06-03 23:56] Guard #2027 begins shift
[1518-05-31 00:00] Guard #2027 begins shift
[1518-06-05 00:37] wakes up
[1518-11-01 00:42] falls asleep
[1518-07-03 00:39] wakes up
[1518-08-04 23:56] Guard #2969 begins shift
[1518-02-22 23:58] Guard #3067 begins shift
[1518-07-15 00:31] falls asleep
[1518-03-27 00:54] wakes up
[1518-06-07 00:14] falls asleep
[1518-05-14 23:50] Guard #1129 begins shift
[1518-06-23 00:18] falls asleep
[1518-03-24 23:57] Guard #1627 begins shift
[1518-06-13 23:58] Guard #587 begins shift
[1518-04-18 23:56] Guard #2027 begins shift
[1518-09-12 00:15] falls asleep
[1518-11-15 00:56] wakes up
[1518-03-09 00:13] falls asleep
[1518-08-26 00:43] falls asleep
[1518-04-27 00:14] falls asleep
[1518-05-21 00:51] wakes up
[1518-04-28 00:00] Guard #2969 begins shift
[1518-10-21 00:48] falls asleep
[1518-05-01 23:56] Guard #3083 begins shift
[1518-10-05 00:50] wakes up
[1518-08-22 00:19] falls asleep
[1518-10-18 00:41] wakes up
[1518-08-29 00:56] wakes up
[1518-04-03 00:27] falls asleep
[1518-08-07 00:12] falls asleep
[1518-08-27 00:38] wakes up
[1518-07-14 23:58] Guard #3083 begins shift
[1518-06-29 23:47] Guard #919 begins shift
[1518-06-15 00:37] falls asleep
[1518-03-24 00:33] falls asleep
[1518-08-04 00:55] falls asleep
[1518-09-30 00:15] falls asleep
[1518-05-06 00:34] falls asleep
[1518-06-16 00:55] wakes up
[1518-04-04 00:16] falls asleep
[1518-09-26 00:35] falls asleep
[1518-07-12 23:58] Guard #3083 begins shift
[1518-03-27 23:59] Guard #2741 begins shift
[1518-07-21 00:08] wakes up
[1518-05-22 23:53] Guard #2027 begins shift
[1518-07-30 00:39] falls asleep
[1518-03-21 00:56] wakes up
[1518-11-12 00:39] wakes up
[1518-10-06 00:02] falls asleep
[1518-10-27 23:56] Guard #2417 begins shift
[1518-08-19 23:57] Guard #1301 begins shift
[1518-02-21 00:01] Guard #797 begins shift
[1518-06-25 00:41] falls asleep
[1518-06-11 00:18] falls asleep
[1518-08-15 00:59] wakes up
[1518-11-20 00:33] wakes up
[1518-03-06 00:47] wakes up
[1518-10-16 23:52] Guard #3067 begins shift
[1518-03-30 00:51] falls asleep
[1518-09-27 00:18] falls asleep
[1518-08-18 00:25] wakes up
[1518-11-20 00:17] wakes up
[1518-05-24 00:59] wakes up
[1518-05-20 00:55] falls asleep
[1518-09-13 00:38] falls asleep
[1518-11-17 00:10] falls asleep
[1518-03-02 23:57] Guard #2473 begins shift
[1518-06-29 00:57] wakes up
[1518-07-05 00:03] Guard #2969 begins shift
[1518-03-26 00:14] falls asleep
[1518-05-24 00:31] falls asleep
[1518-05-21 00:38] falls asleep
[1518-11-04 00:40] falls asleep
[1518-04-24 00:24] wakes up
[1518-11-06 00:00] Guard #521 begins shift
[1518-06-26 00:00] Guard #829 begins shift
[1518-08-29 00:55] falls asleep
[1518-06-16 23:56] Guard #1601 begins shift
[1518-05-17 00:05] falls asleep
[1518-03-08 00:02] falls asleep
[1518-05-16 00:15] wakes up
[1518-09-22 00:41] falls asleep
[1518-11-23 00:45] wakes up
[1518-10-31 00:42] wakes up
[1518-09-16 00:00] Guard #349 begins shift
[1518-04-09 00:07] falls asleep
[1518-05-27 00:57] wakes up
[1518-11-19 00:30] wakes up
[1518-04-09 00:24] wakes up
[1518-09-04 00:34] falls asleep
[1518-05-01 00:53] wakes up
[1518-05-23 00:27] wakes up
[1518-09-25 00:50] wakes up
[1518-05-14 00:52] falls asleep
[1518-04-10 00:57] wakes up
[1518-08-12 00:37] falls asleep
[1518-08-02 00:28] falls asleep
[1518-05-12 23:59] Guard #2473 begins shift
[1518-09-26 00:41] wakes up
[1518-10-24 00:42] wakes up
[1518-02-17 00:32] wakes up
[1518-09-23 00:02] Guard #2473 begins shift
[1518-06-02 00:26] wakes up
[1518-09-19 00:45] wakes up
[1518-07-14 00:55] wakes up
[1518-10-02 00:35] wakes up
[1518-07-18 00:13] falls asleep
[1518-08-18 23:57] Guard #67 begins shift
[1518-09-19 00:52] falls asleep
[1518-07-23 00:46] falls asleep
[1518-08-23 00:33] falls asleep
[1518-02-23 23:58] Guard #479 begins shift
[1518-06-30 00:01] falls asleep
[1518-02-19 00:07] falls asleep
[1518-07-09 00:01] Guard #2969 begins shift
[1518-11-20 00:51] wakes up
[1518-04-29 00:57] wakes up
[1518-10-16 00:43] wakes up
[1518-10-20 00:35] wakes up
[1518-07-28 00:29] wakes up
[1518-10-16 00:53] falls asleep
[1518-10-19 23:58] Guard #2969 begins shift
[1518-11-13 00:28] wakes up
[1518-08-27 00:49] falls asleep
[1518-10-01 00:45] wakes up
[1518-03-07 00:30] falls asleep
[1518-07-19 23:57] Guard #1129 begins shift
[1518-06-15 00:41] wakes up
[1518-08-08 00:26] wakes up
[1518-06-04 00:27] wakes up
[1518-11-09 00:45] falls asleep
[1518-02-22 00:40] wakes up
[1518-04-10 00:31] falls asleep
[1518-09-12 00:12] wakes up
[1518-05-28 00:15] falls asleep
[1518-08-01 23:56] Guard #229 begins shift
[1518-03-31 00:48] wakes up
[1518-05-27 00:27] falls asleep
[1518-09-03 00:03] falls asleep
[1518-07-23 00:58] wakes up
[1518-05-25 00:12] wakes up
[1518-03-19 00:48] falls asleep
[1518-10-30 00:18] falls asleep
[1518-05-07 00:56] wakes up
[1518-10-08 00:00] Guard #2473 begins shift
[1518-03-30 00:27] falls asleep
[1518-09-21 23:57] Guard #1621 begins shift
[1518-11-20 00:21] falls asleep
[1518-10-10 00:18] falls asleep
[1518-11-01 00:53] wakes up
[1518-08-13 00:49] wakes up
[1518-08-24 00:22] wakes up
[1518-09-03 00:52] falls asleep
[1518-02-21 00:43] wakes up
[1518-09-15 00:44] wakes up
[1518-05-26 00:43] falls asleep
[1518-06-24 00:59] wakes up
[1518-08-07 23:50] Guard #3083 begins shift
[1518-07-20 00:48] falls asleep
[1518-10-27 00:34] falls asleep
[1518-08-29 00:42] wakes up
[1518-11-15 00:20] wakes up
[1518-10-11 00:40] falls asleep
[1518-06-26 00:46] wakes up
[1518-09-21 00:00] Guard #67 begins shift
[1518-07-19 00:21] wakes up
[1518-09-27 00:52] wakes up
[1518-04-29 00:12] falls asleep
[1518-11-20 00:08] falls asleep
[1518-06-30 23:58] Guard #67 begins shift
[1518-07-29 00:04] falls asleep
[1518-04-16 00:10] wakes up
[1518-04-05 00:35] falls asleep
[1518-10-01 00:54] wakes up
[1518-11-20 00:01] Guard #797 begins shift
[1518-08-04 00:09] falls asleep
[1518-09-13 00:00] Guard #2741 begins shift
[1518-11-21 00:57] wakes up
[1518-03-22 00:26] wakes up
[1518-03-16 00:54] falls asleep
[1518-06-09 00:21] wakes up
[1518-10-01 00:57] falls asleep
[1518-11-08 00:35] falls asleep
[1518-05-13 00:59] wakes up
[1518-04-30 00:44] wakes up
[1518-07-17 00:04] Guard #2473 begins shift
[1518-04-24 00:49] wakes up
[1518-03-18 00:32] falls asleep
[1518-10-05 00:15] falls asleep
[1518-09-25 00:41] falls asleep
[1518-06-07 00:42] wakes up
[1518-07-24 00:40] falls asleep
[1518-04-16 00:04] Guard #797 begins shift
[1518-09-01 00:21] falls asleep
[1518-07-12 00:43] wakes up
[1518-09-14 00:25] wakes up
[1518-03-05 00:40] wakes up
[1518-05-06 00:56] wakes up
[1518-06-30 00:32] wakes up
[1518-11-13 00:01] falls asleep
[1518-10-01 00:20] falls asleep
[1518-08-11 23:58] Guard #2969 begins shift
[1518-07-20 00:53] wakes up
[1518-06-29 00:27] falls asleep
[1518-07-16 00:02] Guard #2969 begins shift
[1518-10-24 00:50] falls asleep
[1518-06-16 00:26] falls asleep
[1518-11-21 00:06] falls asleep
[1518-03-17 00:44] wakes up
[1518-04-20 00:27] falls asleep
[1518-10-11 00:03] Guard #1129 begins shift
[1518-09-25 00:33] wakes up
[1518-04-02 00:55] wakes up
[1518-04-07 00:07] falls asleep
[1518-08-09 00:23] wakes up
[1518-06-13 00:59] wakes up
[1518-07-08 00:06] falls asleep
[1518-10-26 00:20] falls asleep
[1518-10-28 23:56] Guard #349 begins shift
[1518-04-25 00:59] wakes up
[1518-04-12 00:36] wakes up
[1518-08-24 23:54] Guard #919 begins shift
[1518-04-24 00:53] falls asleep
[1518-07-08 00:33] wakes up
[1518-09-23 23:48] Guard #229 begins shift
[1518-09-14 00:04] Guard #521 begins shift
[1518-05-08 00:00] Guard #479 begins shift
[1518-10-03 00:47] wakes up
[1518-09-12 00:56] wakes up
[1518-11-20 00:36] falls asleep
[1518-04-03 00:57] wakes up
[1518-05-19 00:28] falls asleep
[1518-09-26 00:58] wakes up
[1518-06-12 00:45] falls asleep
[1518-09-07 00:27] falls asleep
[1518-07-14 00:51] wakes up
[1518-02-24 00:08] falls asleep
[1518-09-28 00:46] wakes up
[1518-04-28 00:47] falls asleep
[1518-04-29 00:00] Guard #229 begins shift
[1518-05-25 23:53] Guard #67 begins shift
[1518-08-31 00:24] falls asleep
[1518-03-23 00:10] falls asleep
[1518-03-19 23:49] Guard #1301 begins shift
[1518-07-27 00:49] wakes up
[1518-06-06 00:51] wakes up
[1518-05-23 23:59] Guard #1601 begins shift
[1518-06-22 00:53] wakes up
[1518-08-08 00:47] wakes up
[1518-05-10 00:05] falls asleep
[1518-06-17 00:56] wakes up
[1518-04-30 00:00] Guard #3067 begins shift
[1518-08-26 00:40] wakes up
[1518-10-10 00:24] wakes up
[1518-11-09 00:08] falls asleep
[1518-08-10 00:07] falls asleep
[1518-04-15 00:00] Guard #2027 begins shift
[1518-07-24 23:53] Guard #2969 begins shift
[1518-07-20 00:23] wakes up
[1518-08-14 23:46] Guard #521 begins shift
[1518-11-20 00:48] falls asleep
[1518-03-12 00:54] wakes up
[1518-11-14 00:53] wakes up
[1518-10-01 00:48] falls asleep
[1518-10-18 00:04] Guard #587 begins shift
[1518-09-23 00:54] falls asleep
[1518-08-19 00:31] falls asleep
[1518-05-07 00:00] falls asleep
[1518-05-05 00:56] wakes up
[1518-06-02 00:00] Guard #2969 begins shift
[1518-09-04 00:20] wakes up
[1518-08-19 00:48] wakes up
[1518-03-12 23:56] Guard #1301 begins shift
[1518-10-22 00:33] falls asleep
[1518-07-22 00:46] falls asleep
[1518-11-04 00:48] wakes up
[1518-08-21 00:09] wakes up
[1518-08-23 00:03] Guard #67 begins shift
[1518-04-30 00:31] falls asleep
[1518-08-18 00:52] wakes up
[1518-08-19 00:25] wakes up
[1518-09-04 00:05] falls asleep
[1518-07-30 00:33] wakes up
[1518-08-24 00:17] falls asleep
[1518-07-07 00:15] falls asleep
[1518-09-14 23:50] Guard #521 begins shift
[1518-08-01 00:56] wakes up
[1518-02-20 00:28] falls asleep
[1518-09-01 00:32] wakes up
[1518-02-17 00:14] falls asleep
[1518-09-11 00:51] wakes up
[1518-05-10 00:56] wakes up
[1518-05-23 00:49] wakes up
[1518-10-08 00:50] falls asleep
[1518-08-07 00:00] Guard #797 begins shift
[1518-03-31 00:00] Guard #2969 begins shift
[1518-03-28 00:56] wakes up
[1518-05-10 00:31] wakes up
[1518-04-12 00:56] wakes up
[1518-03-14 00:03] Guard #2473 begins shift
[1518-05-13 23:56] Guard #479 begins shift
[1518-11-09 00:25] wakes up
[1518-04-28 00:52] wakes up
[1518-08-01 00:52] falls asleep
[1518-05-04 23:51] Guard #1601 begins shift
[1518-02-24 00:55] wakes up
[1518-04-25 00:51] wakes up
[1518-10-03 00:04] falls asleep
[1518-10-26 00:44] wakes up
[1518-08-13 00:02] Guard #1129 begins shift
[1518-05-11 00:13] wakes up
[1518-06-14 00:53] wakes up
[1518-10-16 00:25] falls asleep
[1518-10-02 00:42] falls asleep
[1518-03-02 00:57] wakes up
[1518-05-30 00:43] wakes up
[1518-05-10 23:50] Guard #1301 begins shift
[1518-03-10 00:01] falls asleep
[1518-09-15 00:19] wakes up
[1518-06-15 00:03] falls asleep
[1518-06-28 00:51] wakes up
[1518-04-04 00:04] Guard #587 begins shift
[1518-10-22 00:03] Guard #521 begins shift
[1518-04-19 00:52] falls asleep
[1518-04-05 00:56] wakes up
[1518-05-11 00:52] wakes up
[1518-05-19 00:11] falls asleep
[1518-06-03 00:44] falls asleep
[1518-04-26 00:56] falls asleep
[1518-02-26 00:17] falls asleep
[1518-03-14 00:45] wakes up
[1518-03-12 00:02] Guard #67 begins shift
[1518-11-14 00:27] falls asleep
[1518-04-13 00:27] wakes up
[1518-07-14 00:54] falls asleep
[1518-09-09 00:50] wakes up
[1518-10-31 00:21] falls asleep
[1518-06-30 00:55] wakes up
[1518-07-01 00:14] wakes up
[1518-07-23 00:15] wakes up
[1518-08-23 00:59] wakes up
[1518-07-20 23:48] Guard #1301 begins shift
[1518-02-19 00:39] wakes up
[1518-08-05 00:51] falls asleep
[1518-08-26 00:04] Guard #349 begins shift
[1518-07-11 00:29] wakes up
[1518-10-20 23:56] Guard #2741 begins shift
[1518-09-08 00:02] Guard #2969 begins shift
[1518-11-15 00:55] falls asleep
[1518-07-27 23:56] Guard #349 begins shift
[1518-07-25 00:48] wakes up
[1518-10-22 00:24] wakes up
[1518-10-25 00:39] wakes up
[1518-06-26 23:50] Guard #2741 begins shift
[1518-03-18 00:53] falls asleep
[1518-07-22 23:58] Guard #829 begins shift
[1518-04-24 00:58] wakes up
[1518-02-23 00:44] wakes up
[1518-05-23 00:36] falls asleep
[1518-07-26 00:01] Guard #587 begins shift
[1518-06-28 00:50] falls asleep
[1518-03-16 00:45] falls asleep
[1518-10-04 00:50] wakes up
[1518-06-23 00:00] Guard #2969 begins shift
[1518-07-21 00:39] falls asleep
[1518-10-17 00:57] wakes up
[1518-08-08 00:37] falls asleep
[1518-07-27 00:40] falls asleep
[1518-07-13 00:55] wakes up
[1518-03-28 00:55] falls asleep
[1518-07-03 00:05] falls asleep
[1518-09-19 00:06] falls asleep
[1518-04-12 23:59] Guard #2417 begins shift
[1518-05-25 00:29] wakes up
[1518-04-13 00:56] wakes up
[1518-08-24 00:03] Guard #587 begins shift
[1518-02-28 00:00] Guard #521 begins shift
[1518-03-31 00:46] falls asleep
[1518-08-04 00:43] wakes up
[1518-08-31 00:54] wakes up
[1518-10-09 00:42] falls asleep
[1518-09-11 23:49] Guard #67 begins shift
[1518-03-12 00:53] falls asleep
[1518-08-04 00:01] Guard #349 begins shift
[1518-11-18 23:57] Guard #2741 begins shift
[1518-06-21 00:24] falls asleep
[1518-08-10 00:24] falls asleep
[1518-11-23 00:51] falls asleep
[1518-04-30 00:06] falls asleep
[1518-05-10 00:35] falls asleep
[1518-03-01 00:44] wakes up
[1518-06-30 00:47] falls asleep
[1518-06-03 00:21] falls asleep
[1518-09-17 23:52] Guard #479 begins shift
[1518-11-19 00:35] falls asleep
[1518-11-20 23:59] Guard #229 begins shift
[1518-03-09 00:47] wakes up
[1518-11-05 00:28] wakes up
[1518-03-30 00:45] wakes up
[1518-04-14 00:07] falls asleep
[1518-09-02 00:23] falls asleep
[1518-05-20 00:37] falls asleep
[1518-03-12 00:48] wakes up
[1518-03-10 23:56] Guard #1301 begins shift
[1518-09-28 00:17] wakes up
[1518-04-24 00:41] falls asleep
[1518-03-23 00:58] wakes up
[1518-10-25 00:56] wakes up
[1518-08-30 23:59] Guard #2969 begins shift
[1518-05-16 00:41] wakes up
[1518-03-07 23:51] Guard #2969 begins shift
[1518-05-06 00:05] falls asleep
[1518-04-19 23:58] Guard #587 begins shift
[1518-09-08 00:44] falls asleep
[1518-09-05 00:06] falls asleep
[1518-06-13 00:45] wakes up
[1518-11-15 00:01] Guard #587 begins shift
[1518-07-23 00:07] falls asleep
[1518-03-20 00:31] wakes up
[1518-07-10 00:44] falls asleep
[1518-10-22 00:06] falls asleep
[1518-10-02 00:48] wakes up
[1518-04-19 00:28] wakes up
[1518-05-26 00:46] wakes up
[1518-06-29 00:40] wakes up
[1518-05-22 00:59] wakes up
[1518-08-07 00:58] wakes up
[1518-11-21 00:49] wakes up
[1518-02-26 00:52] wakes up
[1518-11-14 00:00] Guard #2969 begins shift
[1518-06-18 00:00] Guard #1627 begins shift
[1518-09-24 00:46] wakes up
[1518-08-19 00:16] falls asleep
[1518-10-31 00:53] falls asleep
[1518-06-24 00:06] falls asleep
[1518-08-24 00:56] wakes up
[1518-08-10 23:56] Guard #587 begins shift
[1518-04-24 00:11] falls asleep
[1518-03-04 00:18] falls asleep
[1518-10-15 00:33] wakes up
[1518-03-19 00:32] falls asleep
[1518-04-13 00:12] falls asleep
[1518-06-18 23:59] Guard #1601 begins shift
[1518-09-02 00:16] wakes up
[1518-09-19 00:53] wakes up
[1518-11-10 00:38] falls asleep
[1518-03-24 00:15] falls asleep
[1518-08-13 00:58] wakes up
[1518-08-17 00:47] wakes up
[1518-11-10 00:56] wakes up
[1518-10-04 00:45] falls asleep
[1518-07-17 00:50] wakes up
[1518-08-19 00:56] falls asleep
[1518-07-21 00:51] wakes up
[1518-03-30 00:56] wakes up
[1518-05-17 00:18] wakes up
[1518-03-14 00:37] falls asleep
[1518-08-09 00:06] falls asleep
[1518-06-27 23:56] Guard #479 begins shift
[1518-06-09 00:12] falls asleep
[1518-04-22 23:57] Guard #587 begins shift
[1518-10-28 00:34] wakes up
[1518-04-16 00:26] wakes up
[1518-05-31 00:25] falls asleep
[1518-11-03 00:01] Guard #587 begins shift
[1518-10-09 00:58] wakes up
[1518-04-16 00:08] falls asleep
[1518-07-21 00:54] falls asleep
[1518-04-10 00:54] falls asleep
[1518-09-09 00:09] falls asleep
[1518-05-09 00:36] wakes up
[1518-09-22 00:56] wakes up
[1518-06-12 00:42] wakes up
[1518-09-19 23:49] Guard #229 begins shift
[1518-06-03 00:30] wakes up
[1518-05-29 00:11] falls asleep
[1518-07-10 00:56] wakes up
[1518-05-13 00:35] falls asleep
[1518-03-28 00:38] falls asleep
[1518-02-28 00:57] wakes up
[1518-09-27 00:00] Guard #3083 begins shift
[1518-03-09 00:52] falls asleep
[1518-03-13 00:59] wakes up
[1518-06-11 00:36] wakes up
[1518-08-18 00:01] Guard #587 begins shift
[1518-11-09 00:20] falls asleep
[1518-03-19 00:35] wakes up
[1518-03-21 23:50] Guard #2417 begins shift
[1518-10-26 00:05] falls asleep
[1518-03-23 00:40] falls asleep
[1518-07-05 00:25] falls asleep
[1518-04-26 00:58] wakes up
[1518-04-13 00:33] falls asleep
[1518-05-17 00:36] wakes up
[1518-08-04 00:59] wakes up
[1518-10-03 00:50] falls asleep
[1518-02-20 00:58] wakes up
[1518-05-05 23:50] Guard #1621 begins shift
[1518-04-26 00:53] wakes up
[1518-10-31 23:56] Guard #3083 begins shift
[1518-06-04 00:11] falls asleep
[1518-06-13 00:56] falls asleep
[1518-10-22 23:52] Guard #2027 begins shift
[1518-05-02 00:27] wakes up
[1518-05-01 00:21] falls asleep
[1518-07-08 00:04] Guard #3067 begins shift
[1518-06-13 00:03] falls asleep
[1518-07-10 00:25] falls asleep
[1518-06-14 23:52] Guard #67 begins shift
[1518-02-18 00:34] wakes up
[1518-10-15 00:56] falls asleep
[1518-10-02 23:52] Guard #3083 begins shift
[1518-04-18 00:19] falls asleep
[1518-02-18 00:00] Guard #2741 begins shift
[1518-07-19 00:19] falls asleep
[1518-05-27 00:04] Guard #2027 begins shift
[1518-07-16 00:52] wakes up
[1518-06-29 00:01] Guard #1601 begins shift
[1518-03-27 00:14] wakes up
[1518-07-28 00:55] wakes up
[1518-03-16 00:59] wakes up
[1518-08-22 00:58] wakes up
[1518-05-14 00:45] wakes up
[1518-11-16 00:45] wakes up
[1518-03-22 00:45] falls asleep
[1518-03-17 00:02] Guard #2027 begins shift
[1518-03-13 00:26] falls asleep
[1518-08-02 00:47] wakes up
[1518-08-19 00:57] wakes up
[1518-06-10 23:59] Guard #587 begins shift
[1518-10-29 23:52] Guard #1601 begins shift
[1518-11-12 00:01] Guard #67 begins shift
[1518-05-25 00:36] falls asleep
[1518-03-23 00:49] wakes up
[1518-09-05 00:48] wakes up
[1518-11-03 00:46] wakes up
[1518-04-08 00:03] Guard #2027 begins shift
[1518-04-21 00:28] falls asleep
[1518-05-22 00:02] Guard #479 begins shift
[1518-07-05 00:30] wakes up
[1518-10-02 00:53] falls asleep
[1518-05-02 00:47] falls asleep
[1518-11-07 00:33] falls asleep
[1518-05-17 00:26] falls asleep
[1518-05-25 00:24] falls asleep
[1518-06-07 00:01] Guard #229 begins shift
[1518-05-01 00:00] Guard #2741 begins shift
[1518-03-09 23:48] Guard #2969 begins shift
[1518-08-08 00:50] falls asleep
[1518-03-23 00:00] Guard #3067 begins shift
[1518-11-12 00:21] falls asleep
[1518-09-16 00:36] wakes up
[1518-10-13 00:42] falls asleep
[1518-11-08 00:53] wakes up
[1518-11-02 00:58] wakes up
[1518-10-03 00:26] wakes up
[1518-10-02 00:34] falls asleep
[1518-02-21 00:18] falls asleep
[1518-04-27 00:48] wakes up
[1518-10-29 00:07] falls asleep
[1518-07-29 23:56] Guard #521 begins shift
[1518-08-29 00:37] falls asleep
[1518-04-01 00:04] Guard #1627 begins shift
[1518-03-22 00:50] wakes up
[1518-08-06 00:01] Guard #349 begins shift
[1518-04-15 00:28] falls asleep
[1518-05-20 23:59] Guard #797 begins shift
[1518-02-25 00:12] falls asleep
[1518-06-08 00:29] wakes up
[1518-06-23 00:44] falls asleep
[1518-04-02 00:39] falls asleep
[1518-07-26 23:56] Guard #229 begins shift
[1518-06-12 00:16] falls asleep
[1518-05-10 00:47] falls asleep
[1518-11-05 00:17] falls asleep
[1518-08-31 23:59] Guard #2027 begins shift
[1518-10-20 00:18] falls asleep
[1518-10-23 00:01] falls asleep
[1518-04-11 23:47] Guard #919 begins shift
[1518-07-01 00:49] wakes up
[1518-08-12 00:27] wakes up
[1518-04-08 00:18] falls asleep
[1518-03-10 00:13] wakes up
[1518-05-18 00:56] wakes up
[1518-04-24 23:57] Guard #67 begins shift
[1518-03-07 00:07] falls asleep
[1518-06-22 00:14] falls asleep
[1518-09-25 00:13] falls asleep
[1518-06-08 00:20] falls asleep
[1518-02-23 00:13] falls asleep
[1518-04-23 00:58] wakes up
[1518-09-19 00:04] Guard #797 begins shift
[1518-06-09 00:00] Guard #2027 begins shift
[1518-08-26 00:31] falls asleep
[1518-10-23 00:20] wakes up
[1518-10-05 23:47] Guard #229 begins shift
[1518-07-06 00:31] wakes up
[1518-07-01 00:28] falls asleep
[1518-03-27 00:44] falls asleep
[1518-04-13 00:50] falls asleep
[1518-07-22 00:02] Guard #2969 begins shift
[1518-05-16 00:19] falls asleep
[1518-02-27 00:35] falls asleep
[1518-03-31 00:20] wakes up
[1518-03-26 23:49] Guard #919 begins shift
[1518-03-08 00:46] wakes up
[1518-10-06 23:58] Guard #3067 begins shift
[1518-03-09 00:58] wakes up
[1518-10-30 00:01] falls asleep
[1518-06-20 00:27] falls asleep
[1518-06-03 00:53] wakes up
[1518-08-20 00:57] wakes up
[1518-06-20 00:32] wakes up
[1518-08-25 00:36] wakes up
[1518-11-05 00:00] Guard #1601 begins shift
[1518-08-13 00:38] falls asleep
[1518-09-07 00:49] falls asleep
[1518-06-14 00:16] wakes up
[1518-06-14 00:10] falls asleep
[1518-11-06 00:11] falls asleep
[1518-04-15 00:25] wakes up
[1518-09-28 00:10] falls asleep
[1518-05-06 23:47] Guard #67 begins shift
[1518-10-08 00:53] wakes up
[1518-05-15 00:05] falls asleep
[1518-10-05 00:03] Guard #919 begins shift
[1518-05-03 00:01] Guard #1129 begins shift
[1518-11-15 23:50] Guard #587 begins shift
[1518-08-10 00:04] Guard #1129 begins shift
[1518-06-19 00:51] wakes up
[1518-04-10 00:34] wakes up
[1518-08-14 00:37] wakes up
[1518-10-09 00:17] falls asleep
[1518-09-29 00:59] wakes up
[1518-10-01 00:01] Guard #587 begins shift
[1518-09-15 00:02] falls asleep
[1518-09-02 23:46] Guard #3083 begins shift
[1518-04-06 00:07] falls asleep
[1518-03-22 00:02] falls asleep
[1518-05-05 00:32] wakes up
[1518-11-02 00:23] falls asleep
[1518-04-08 00:49] wakes up
[1518-09-27 00:46] falls asleep
[1518-07-12 00:19] falls asleep
[1518-09-11 00:17] falls asleep
[1518-02-20 00:48] wakes up
[1518-03-17 00:24] falls asleep
[1518-07-14 00:00] Guard #3083 begins shift
[1518-03-11 00:33] falls asleep
[1518-08-10 00:18] wakes up
[1518-09-03 23:47] Guard #919 begins shift
[1518-02-17 00:00] Guard #1621 begins shift
[1518-04-25 00:56] falls asleep
[1518-11-07 00:59] wakes up
[1518-07-02 00:46] wakes up
[1518-10-26 00:12] wakes up
[1518-11-07 00:04] Guard #587 begins shift
[1518-09-09 00:21] falls asleep
[1518-03-06 23:59] Guard #2417 begins shift
[1518-04-20 23:57] Guard #349 begins shift
[1518-05-22 00:15] falls asleep
[1518-06-02 00:43] falls asleep
[1518-03-03 00:17] falls asleep
[1518-03-11 00:52] wakes up
[1518-07-22 00:56] wakes up
[1518-04-27 00:02] Guard #829 begins shift
[1518-09-25 00:02] Guard #67 begins shift
[1518-06-16 00:03] Guard #1301 begins shift
[1518-07-02 00:53] falls asleep
[1518-11-23 00:53] wakes up
[1518-04-06 00:56] wakes up
[1518-08-22 00:04] Guard #479 begins shift
[1518-09-07 00:56] wakes up
[1518-09-21 00:49] wakes up
[1518-10-13 00:35] wakes up
[1518-08-08 00:04] falls asleep
[1518-08-18 00:44] falls asleep
[1518-06-12 00:55] wakes up
[1518-03-20 00:04] falls asleep
[1518-06-09 23:59] Guard #3083 begins shift
[1518-07-10 00:00] Guard #229 begins shift
[1518-07-09 00:55] wakes up
[1518-10-06 00:44] falls asleep
[1518-11-01 23:56] Guard #521 begins shift
[1518-07-07 00:49] wakes up
[1518-04-03 00:03] Guard #829 begins shift
[1518-10-15 00:58] wakes up
[1518-10-21 00:20] falls asleep
[1518-08-27 00:09] falls asleep
[1518-05-11 00:39] falls asleep
[1518-10-01 00:59] wakes up
[1518-10-28 00:57] wakes up
[1518-10-23 23:57] Guard #797 begins shift
[1518-05-08 00:45] falls asleep
[1518-05-19 00:01] Guard #2473 begins shift
[1518-10-06 00:15] wakes up
[1518-04-17 00:52] wakes up
[1518-02-22 00:07] falls asleep
[1518-04-10 23:58] Guard #3083 begins shift
[1518-10-20 00:40] falls asleep
[1518-07-06 00:23] falls asleep
[1518-04-15 00:16] falls asleep
[1518-08-15 00:03] falls asleep
[1518-08-15 23:50] Guard #521 begins shift
[1518-08-06 00:20] falls asleep
[1518-05-25 00:00] Guard #1621 begins shift
[1518-04-25 23:59] Guard #3067 begins shift
[1518-05-20 00:24] falls asleep
[1518-06-22 00:39] falls asleep
[1518-08-29 23:59] Guard #829 begins shift
[1518-06-22 00:44] falls asleep
[1518-03-18 00:44] wakes up
[1518-04-18 00:00] Guard #1301 begins shift
[1518-10-12 00:04] Guard #2699 begins shift
[1518-04-12 00:03] falls asleep
[1518-09-16 00:14] wakes up
[1518-05-21 00:33] wakes up
[1518-03-04 00:42] wakes up
[1518-06-02 00:19] falls asleep
[1518-09-19 00:40] falls asleep
[1518-08-05 00:56] wakes up
[1518-06-13 00:50] wakes up
[1518-03-29 00:31] falls asleep
[1518-03-28 00:06] falls asleep
[1518-11-08 00:32] wakes up
[1518-05-05 00:04] falls asleep
[1518-05-28 00:03] Guard #3083 begins shift
[1518-07-09 00:25] falls asleep
[1518-05-11 23:59] Guard #2699 begins shift
[1518-06-06 00:11] falls asleep
[1518-10-13 00:09] falls asleep
[1518-06-19 23:56] Guard #3083 begins shift
[1518-06-21 23:56] Guard #1301 begins shift
[1518-09-30 00:17] wakes up
[1518-10-16 00:02] Guard #1601 begins shift
[1518-06-05 23:56] Guard #67 begins shift
[1518-07-15 00:25] falls asleep
[1518-02-25 00:26] wakes up
[1518-07-13 00:30] falls asleep
[1518-11-01 00:27] falls asleep
[1518-03-26 00:44] wakes up
[1518-11-16 00:00] falls asleep
[1518-07-31 00:48] wakes up
[1518-04-12 00:33] falls asleep
[1518-07-15 00:28] wakes up
[1518-04-14 00:03] Guard #797 begins shift
[1518-08-30 00:45] wakes up
[1518-11-16 00:52] falls asleep
[1518-03-17 23:59] Guard #1301 begins shift
[1518-10-19 00:34] wakes up
[1518-05-10 00:37] wakes up
[1518-10-02 00:17] falls asleep
[1518-05-03 00:52] wakes up
[1518-05-19 00:23] wakes up
[1518-10-29 00:46] wakes up
[1518-03-07 00:19] wakes up
[1518-08-05 00:48] wakes up
[1518-03-05 00:02] Guard #1621 begins shift
[1518-09-30 00:05] falls asleep
[1518-09-08 23:56] Guard #349 begins shift
[1518-08-15 00:56] falls asleep
[1518-11-16 00:25] falls asleep
[1518-04-19 00:24] falls asleep
[1518-04-16 00:18] falls asleep
[1518-04-13 00:45] wakes up
[1518-05-27 00:50] falls asleep
[1518-10-16 00:55] wakes up
[1518-06-26 00:35] falls asleep
[1518-07-21 00:16] falls asleep
[1518-03-24 00:17] wakes up
[1518-07-29 00:45] wakes up
[1518-10-07 00:45] wakes up
[1518-05-11 00:02] falls asleep
[1518-10-27 00:58] wakes up
[1518-03-26 00:02] Guard #521 begins shift
[1518-07-11 23:58] Guard #2741 begins shift
[1518-03-18 00:57] wakes up
[1518-11-20 00:37] wakes up
[1518-08-27 00:58] wakes up
[1518-02-18 00:18] falls asleep
[1518-09-20 00:35] wakes up
[1518-10-27 00:03] Guard #229 begins shift
[1518-09-24 00:05] falls asleep
[1518-09-16 23:56] Guard #2741 begins shift
[1518-03-15 00:04] Guard #1051 begins shift
[1518-08-26 23:58] Guard #2741 begins shift
[1518-07-21 00:01] falls asleep
[1518-08-19 00:10] falls asleep
[1518-09-16 00:11] falls asleep
[1518-05-06 00:14] wakes up
[1518-04-08 00:31] falls asleep
[1518-11-23 00:03] falls asleep
[1518-06-27 00:02] falls asleep
[1518-03-03 00:55] wakes up
[1518-09-14 00:11] falls asleep
[1518-03-16 00:48] wakes up
[1518-09-11 00:02] Guard #229 begins shift
[1518-04-23 23:59] Guard #1301 begins shift
[1518-07-24 00:46] wakes up
[1518-05-29 00:28] wakes up
[1518-10-17 00:03] falls asleep
[1518-08-20 00:49] falls asleep
[1518-05-26 00:02] falls asleep
[1518-04-11 00:15] falls asleep
[1518-11-16 00:10] wakes up
[1518-10-22 00:42] wakes up
[1518-10-02 00:54] wakes up
[1518-03-01 00:11] falls asleep
[1518-10-14 23:59] Guard #829 begins shift
[1518-10-09 00:03] Guard #2473 begins shift
[1518-11-22 00:32] wakes up
[1518-10-21 00:49] wakes up
[1518-08-13 00:52] falls asleep
[1518-08-20 23:48] Guard #2969 begins shift
[1518-09-13 00:12] falls asleep
[1518-09-03 00:54] wakes up
[1518-09-04 00:54] wakes up
[1518-06-15 00:12] wakes up
[1518-02-20 00:53] falls asleep
[1518-07-05 23:58] Guard #521 begins shift
[1518-10-24 00:52] wakes up
[1518-05-19 00:54] wakes up
[1518-09-28 00:37] falls asleep
[1518-06-17 00:50] falls asleep
[1518-08-15 00:36] wakes up
[1518-03-21 00:21] falls asleep
[1518-05-21 00:28] falls asleep
[1518-09-24 00:12] wakes up
[1518-06-12 23:51] Guard #1601 begins shift
[1518-08-17 00:04] Guard #587 begins shift
[1518-05-23 00:00] falls asleep
[1518-11-17 00:03] Guard #3067 begins shift
[1518-11-01 00:29] wakes up
[1518-10-13 00:47] wakes up
[1518-11-08 00:20] falls asleep
[1518-09-09 00:13] wakes up
[1518-06-01 00:03] Guard #1051 begins shift
[1518-04-17 00:49] falls asleep
[1518-08-14 00:26] falls asleep
[1518-09-02 00:04] Guard #2741 begins shift
[1518-11-17 23:57] Guard #1051 begins shift
[1518-11-17 00:55] wakes up
[1518-10-28 00:38] falls asleep
[1518-07-03 23:56] Guard #1051 begins shift
[1518-09-30 00:09] wakes up
[1518-09-29 23:50] Guard #67 begins shift
[1518-02-25 23:59] Guard #2473 begins shift
[1518-11-09 00:46] wakes up
[1518-09-07 00:42] wakes up
[1518-08-16 00:55] wakes up
[1518-08-28 00:34] wakes up
[1518-10-18 23:59] Guard #1601 begins shift
[1518-09-17 00:07] falls asleep
[1518-07-15 00:39] wakes up
[1518-09-25 23:56] Guard #521 begins shift
[1518-02-20 00:01] Guard #3083 begins shift
[1518-08-16 00:04] falls asleep
[1518-05-26 00:21] wakes up
[1518-02-21 00:25] falls asleep
[1518-09-21 00:25] falls asleep
[1518-09-17 00:44] wakes up
[1518-06-23 00:57] wakes up
[1518-11-12 23:51] Guard #2027 begins shift
[1518-06-02 00:49] wakes up
[1518-07-18 23:59] Guard #797 begins shift
[1518-06-07 00:25] wakes up
[1518-06-29 00:55] falls asleep
[1518-09-24 00:39] falls asleep
[1518-05-20 00:56] wakes up
[1518-04-11 00:49] wakes up
[1518-04-22 00:11] falls asleep
[1518-06-17 00:07] falls asleep
[1518-08-21 00:05] falls asleep
[1518-05-18 00:24] falls asleep
[1518-08-28 00:00] Guard #2417 begins shift
[1518-07-19 00:37] falls asleep
[1518-04-29 00:25] wakes up
[1518-04-18 00:58] wakes up
[1518-07-02 00:10] falls asleep
[1518-08-25 00:04] falls asleep
[1518-07-11 00:28] falls asleep
[1518-07-14 00:18] falls asleep
[1518-03-06 00:07] falls asleep
[1518-03-17 00:48] falls asleep
[1518-08-01 00:04] Guard #919 begins shift
[1518-09-20 00:54] wakes up
[1518-09-16 00:17] falls asleep
[1518-05-27 00:33] wakes up
[1518-03-03 23:56] Guard #1301 begins shift
[1518-08-19 00:11] wakes up
[1518-11-07 23:58] Guard #349 begins shift
[1518-11-16 00:53] wakes up
[1518-07-01 00:13] falls asleep
[1518-06-07 00:32] falls asleep
[1518-10-10 00:01] Guard #1621 begins shift
[1518-05-04 00:49] wakes up
[1518-09-22 00:50] wakes up
[1518-07-08 00:17] wakes up
[1518-07-19 00:58] wakes up
[1518-09-05 23:56] Guard #2699 begins shift
[1518-07-21 00:33] wakes up
[1518-06-23 00:34] wakes up
[1518-10-18 00:08] falls asleep
[1518-10-14 00:00] Guard #1051 begins shift
[1518-10-31 00:00] Guard #349 begins shift
[1518-06-12 00:00] Guard #3083 begins shift
[1518-11-15 00:09] falls asleep
[1518-07-31 00:00] Guard #1129 begins shift
[1518-10-25 00:00] Guard #1601 begins shift
[1518-10-11 00:59] wakes up
[1518-06-10 00:32] wakes up
[1518-04-29 00:36] falls asleep
[1518-07-30 00:52] wakes up
[1518-07-30 00:09] falls asleep
[1518-09-29 00:53] falls asleep
[1518-03-07 00:48] wakes up
[1518-03-10 00:19] falls asleep
[1518-03-05 00:15] falls asleep
[1518-09-04 23:57] Guard #2027 begins shift
[1518-06-21 00:49] wakes up
[1518-04-20 00:58] wakes up
[1518-08-13 23:57] Guard #1129 begins shift
[1518-03-29 23:56] Guard #587 begins shift
[1518-06-17 00:30] wakes up
[1518-04-30 00:21] wakes up
[1518-04-01 23:57] Guard #2969 begins shift
[1518-07-24 00:01] Guard #479 begins shift
[1518-10-30 00:33] wakes up
[1518-08-05 00:43] falls asleep
[1518-11-22 00:00] Guard #1601 begins shift
[1518-07-20 00:22] falls asleep
[1518-04-04 23:56] Guard #3067 begins shift
[1518-02-24 23:57] Guard #521 begins shift
[1518-05-29 00:03] Guard #2027 begins shift
[1518-06-02 23:58] Guard #2027 begins shift
[1518-04-23 00:53] falls asleep
[1518-11-19 00:56] wakes up
[1518-08-28 00:12] falls asleep
[1518-03-31 00:18] falls asleep
[1518-07-21 00:55] wakes up
[1518-06-13 00:16] falls asleep
[1518-09-19 00:30] wakes up
[1518-11-23 00:22] wakes up
"""

extension String {
    var positiveIntegers: [Int] {
        return self
            .split{ "0123456789".contains($0) == false }
            .map { Int($0)! }
    }
}

class Day {
    let guardId: Int
    var asleepMinutes = [Bool](repeating: false, count: 60)
    
    init(guardId: Int) {
        self.guardId = guardId
    }
}

let lines = input.components(separatedBy: .newlines).sorted()

var days: [Day] = []

for line in lines {
    let numbers = line.positiveIntegers
    
    switch line.components(separatedBy: .whitespaces)[2] {
    case "Guard":
        let guardId = numbers[5]
        days.append(Day(guardId: guardId))
        
    case "falls":
        let day = days.last!
        let asleepMinute = numbers[4]
        day.asleepMinutes[asleepMinute] = true
        
    case "wakes":
        let day = days.last!
        let lastAsleepMinute = day.asleepMinutes.lastIndex(of: true)!
        let awakeMinute = numbers[4]
        
        for idx in lastAsleepMinute ..< awakeMinute {
            day.asleepMinutes[idx] = true
        }
        
    default:
        fatalError("Unexpected input")
    }
}

func partOne() -> String {
    let minutesAsleep = days
        .map { ($0.guardId, $0.asleepMinutes.reduce(into: 0, { if $1 { $0 += 1 } })) }
        .reduce(into: [:], { $0[$1.0, default: 0] += $1.1 })
    
    let sleepiestGuard = minutesAsleep.max { $0.value < $1.value }!
    
    let minutesAsleepCountForSleepiestGuard = days
        .filter { $0.guardId == sleepiestGuard.key }
        .map { $0.asleepMinutes }
        .reduce(into: [Int](repeating: 0, count: 60), {
            for (index, item) in $1.enumerated() {
                if item {
                    $0[index] += 1
                }
            }
        })
    
    let mostAsleepMinuteValue = minutesAsleepCountForSleepiestGuard.max()!
    let mostAsleepMinute = minutesAsleepCountForSleepiestGuard.firstIndex(of: mostAsleepMinuteValue)!
    
    let result = sleepiestGuard.key * mostAsleepMinute
    
    return "\(result)"
}

func partTwo() -> String {
    var minutesAsleep: [Int: [Int]] = [:]
    
    for day in days {
        let guardId = day.guardId
        var minuteSet = minutesAsleep[guardId, default: [Int](repeating: 0, count: 60)]
        for (index, minute) in day.asleepMinutes.enumerated() {
            if minute {
                minuteSet[index] += 1
            }
        }
        minutesAsleep[guardId] = minuteSet
    }

    let minuteMostSleepOn: [Int: (minute: Int, sleeps: Int)] = minutesAsleep.mapValues {
        let maximum = $0.max()!
        let index = $0.firstIndex(of: maximum)!
        return(index, maximum)
    }

    let result = minuteMostSleepOn.max(by: { $0.value.sleeps < $1.value.sleeps })!

    return "\(result.key * result.value.minute)"
}

print(partOne())
print(partTwo())
//: [Next](@next)
