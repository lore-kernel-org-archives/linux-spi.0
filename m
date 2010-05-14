From: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: [PATCH] spi: spidev_test.c: Make transfer size
	suitable for wordsize 32
Date: Fri, 14 May 2010 11:14:27 +0200
Message-ID: <1273828467-4593-2-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1273828467-4593-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1273828467-4593-1-git-send-email-Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
---
 Documentation/spi/spidev_test.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 10abd37..3978e69 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -45,7 +45,6 @@ static void transfer(int fd)
 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
 		0xDE, 0xAD, 0xBE, 0xEF, 0xBA, 0xAD,
-		0xF0, 0x0D,
 	};
 	uint8_t rx[ARRAY_SIZE(tx)] = {0, };
 	struct spi_ioc_transfer tr = {
-- 
1.6.4.4


------------------------------------------------------------------------------
