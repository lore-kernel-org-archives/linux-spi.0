From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: [PATCH 0/3] spi: davinci: move eventq parameter to platform data
Date: Thu,  3 Feb 2011 19:34:47 -0500
Message-ID: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
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

For DMA operation, the davinci spi driver needs an eventq number.
Currently, this number is passed as a IORESOURCE_DMA.  This is not
correct, as the eventq is not a DMA channel.  Pass the eventq
via the platform data structure instead as is done with davinci
devices such as the McASP.

Two platforms (dm355 and dm365) are using the davinci spi driver 
with DMA's enabled, move the eventq parameter out of the resources
and into the platform data.

I have tested this patch with an OMAP-L138 (patch submission for this
platform is in progress).  I do not have a dm355 or dm365, so these
platforms have not been tested.

Michael Williamson (3):
  davinci: spi: move event_q parameter to platform data
  davinci: dm355: move spi0 eventq assignment from resources to
    platform data
  davinci: dm365: move spi0 eventq assignment from resources to
    platform data

 arch/arm/mach-davinci/dm355.c            |    5 +----
 arch/arm/mach-davinci/dm365.c            |    5 +----
 arch/arm/mach-davinci/include/mach/spi.h |   15 ++++++++++-----
 drivers/spi/davinci_spi.c                |   11 +++--------
 4 files changed, 15 insertions(+), 21 deletions(-)
