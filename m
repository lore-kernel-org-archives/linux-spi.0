From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] SPI: Fix apparently reversed args to time_before().
Date: Fri, 1 Jan 2010 12:24:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001011222400.24884@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751847Ab0AARZU@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  given that the macro this is contained in reads:

#define busy_wait(cond)                                           \
        ({                                                        \
        unsigned long end_jiffies = jiffies + STMP_SPI_TIMEOUT;   \
        bool succeeded = false;                                   \
        do {                                                      \
                if (cond) {                                       \
                        succeeded = true;                         \
                        break;                                    \
                }                                                 \
                cpu_relax();                                      \
        } while (time_before(jiffies, end_jiffies));              \
        succeeded;                                                \
        })

it seems obvious that those args are in the wrong order.

diff --git a/drivers/spi/spi_stmp.c b/drivers/spi/spi_stmp.c
index 2552bb3..fadff76 100644
--- a/drivers/spi/spi_stmp.c
+++ b/drivers/spi/spi_stmp.c
@@ -76,7 +76,7 @@ struct stmp_spi {
 			break;						\
 		}							\
 		cpu_relax();						\
-	} while (time_before(end_jiffies, jiffies));			\
+	} while (time_before(jiffies, end_jiffies));			\
 	succeeded;							\
 	})



========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
