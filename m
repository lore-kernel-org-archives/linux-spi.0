From: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH V2] spi: add driver for BCM2835
Date: Tue, 12 Mar 2013 09:29:09 +0000
Message-ID: <513EF565.6050706@bootc.net>
References: <1363059504-13284-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1363059504-13284-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 12/03/13 03:38, Stephen Warren wrote:
> From: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>
> 
> The BCM2835 contains two forms of SPI master controller (one known
> simply as SPI0, and the other known as the "Universal SPI Master", in
> the auxilliary block) and one form of SPI slave controller. This patch
> adds support for the SPI0 controller.
> 
> This driver is taken from Chris Boot's repository at
> git://github.com/bootc/linux.git rpi-linear
> as of commit 6de2905 "spi-bcm2708: fix printf with spurious %s".
> In the first SPI-related commit there, Chris wrote:
> 
> Thanks to csoutreach / A Robinson for his driver which I used as an
> inspiration. You can find his version here:
> http://piface.openlx.org.uk/raspberry-pi-spi-kernel-driver-available-for

Hi Stephen,

Just wanted to say thanks for refreshing and pushing my original patch
through to mainline.

In case it wasn't already obvious:

Signed-off-by: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>

Cheers!
Chris

-- 
Chris Boot
bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org
