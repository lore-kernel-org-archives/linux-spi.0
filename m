From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: Side effect of SPI GPIO descriptor usage
Date: Mon, 2 Dec 2019 12:10:11 +0000
Message-ID: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Language: en-US
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

Hi,

A relatively recent patch [1] to the spi-bcm2835 driver modified it to 
use GPIO descriptors for chip select handling. A side effect of this 
change is to set the SPI_MODE_CS_HIGH flag for devices connected to the 
controller, which seems strange since it happens for devices that 
require the usual active-low chip select.

This change came to light when a user reported that the SPI-Py library
(a client of the spidev driver) wasn't working on 5.4, which was traced 
to it overwriting the SPI mode flags when it was only trying to set the
CPHA and CPOL flags. This had the affect of inverting the chip select
line, with the obvious consequences. That corruption of the flags is 
clearly an error, but what if the application and library were genuinely 
trying to specify that the attached device required an active-high chip 
select? Would it now require that they _clear_ the CS_HIGH flag?

Thanks,

Phil

[1] 3bd158c56a56 ("spi: bcm2835: Convert to use CS GPIO descriptors")
