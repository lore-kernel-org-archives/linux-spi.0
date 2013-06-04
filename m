From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 05/11] spi: omap2-mcspi: enhance pinctrl support
Date: Tue, 4 Jun 2013 09:53:04 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC22370@DBDE04.ent.ti.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
	<1369995191-20855-6-git-send-email-gururaja.hebbar@ti.com>
	<20130601192726.GS16790@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org"
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
        "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
	<linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org"
	<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
        "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org"
	<grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130601192726.GS16790-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 02, 2013 at 00:57:26, Mark Brown wrote:
> On Fri, May 31, 2013 at 03:43:05PM +0530, Hebbar Gururaja wrote:
> > Amend the spi omap controller to optionally take a pin control
> > handle and set the state of the pins to:
> > 
> > - "default" on boot, resume and before performing an spi transfer
> > - "idle" after initial default, after resume default, and after each
> > spi xfer
> > - "sleep" on suspend()
> 
> Looking at this code I can't really see what's OMAP-specific about it -
> exactly the same flow should apply to pretty much any SPI controller,
> especially given that the code will happily ignore missing states.
> We're just setting the idle state when not actively transferring data
> which seems sensible and generic.
> 
> This suggests to me that we should be adding this code into the core,
> probably joined up with the transfer_one_message stuff, so that any
> hardware which has an idle state will be able to get the benefit.  Can
> anyone think of a reason why we shouldn't do that?

Let me pull out some info about these and come back

> 


Regards, 
Gururaja
