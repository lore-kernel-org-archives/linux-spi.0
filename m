From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 11/49] spi: davinci: remove 'wait_enable' platform data member
Date: Wed, 17 Nov 2010 16:13:43 +0530
Message-ID: <1289990661-30126-12-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-11-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

The SPI_READY bit of struct spi_device:mode serves the purpose
of letting the SPI master know if the slave can signal if it is
ready for transfer or not.

The 'wait_enable' platform data was duplicating this functionality.
Use the framework provided method of indicating this capability.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |    1 -
 drivers/spi/davinci_spi.c                |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 734d1fb..fe699140 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -32,7 +32,6 @@ struct davinci_spi_platform_data {
 	u8	wdelay;
 	u8	odd_parity;
 	u8	parity_enable;
-	u8	wait_enable;
 	u8	timer_disable;
 	u8	clk_internal;
 	u8	intr_level;
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 17269ad..5480857 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -522,7 +522,7 @@ static int davinci_spi_setup(struct spi_device *spi)
 					SPIFMT_PARITYENA_MASK,
 					spi->chip_select);
 
-		if (davinci_spi->pdata->wait_enable)
+		if (spi->mode & SPI_READY)
 			set_fmt_bits(davinci_spi->base,
 					SPIFMT_WAITENA_MASK,
 					spi->chip_select);
-- 
1.7.3.2
