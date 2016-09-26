From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 0/2] Moving runnable code from Documentation (last 2 patches)
Date: Mon, 26 Sep 2016 12:40:00 -0600
Message-ID: <cover.1474912582.git.shuahkh@osg.samsung.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-spi@vger.kernel.org
To: corbet@lwn.net, mmarek@suse.com, akpm@linux-foundation.org,
        keescook@chromium.org, dan.j.williams@intel.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, jpoimboe@redhat.com, tj@kernel.org,
        aryabinin@virtuozzo.com, nikolay@cumulusnetworks.com,
        dvyukov@google.com, rostedt@goodmis.org, olof@lixom.net,
        arnd@arndb.de, hans.verkuil@cisco.com, nab@linux-iscsi.org,
        mchehab@kernel.org, broonie@kernel.org, tglx@linutronix.de,
        ecree@solarflare.com, davem@davemloft.net
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series contains the last 2 patches to complete moving runnable
code from Documentation to selftests, samples, and tools.

The first patch moves blackfin gptimers-example to samples and removes
CONFIG_BUILD_DOCSRC.

The second one updates 00-INDEX files under Documentation to reflect the
move of runnable code from Documentation.

Shuah Khan (2):
  samples: move blackfin gptimers-example from Documentation
  Doc: update 00-INDEX files to reflect the runnable code move

 Documentation/00-INDEX                    |  2 -
 Documentation/Makefile                    |  1 -
 Documentation/arm/00-INDEX                |  2 -
 Documentation/blackfin/00-INDEX           |  4 --
 Documentation/blackfin/Makefile           |  5 --
 Documentation/blackfin/gptimers-example.c | 91 -------------------------------
 Documentation/filesystems/00-INDEX        |  2 -
 Documentation/networking/00-INDEX         |  2 -
 Documentation/spi/00-INDEX                |  2 -
 Documentation/timers/00-INDEX             |  2 -
 Makefile                                  |  3 -
 lib/Kconfig.debug                         |  9 ---
 samples/Kconfig                           |  6 ++
 samples/Makefile                          |  2 +-
 samples/blackfin/Makefile                 |  1 +
 samples/blackfin/gptimers-example.c       | 91 +++++++++++++++++++++++++++++++
 16 files changed, 99 insertions(+), 126 deletions(-)
 delete mode 100644 Documentation/Makefile
 delete mode 100644 Documentation/blackfin/Makefile
 delete mode 100644 Documentation/blackfin/gptimers-example.c
 create mode 100644 samples/blackfin/Makefile
 create mode 100644 samples/blackfin/gptimers-example.c

-- 
2.7.4

