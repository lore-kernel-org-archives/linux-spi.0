From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/4] ARM: davinci: da850-evm: add SPI flash support
Date: Wed, 27 Feb 2013 09:29:13 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA47FC7@DBDE01.ent.ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
	<1361789050-637-5-git-send-email-prakash.pm@ti.com>
	<512DC2E5.4080603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org"
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
        "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org"
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
        "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org"
	<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
        "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org"
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <512DC2E5.4080603-l0cyMroinI0@public.gmane.org>
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

On Wed, Feb 27, 2013 at 13:55:09, Nori, Sekhar wrote:
> On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> > Enable m25p80 SPI flash support on da850-EVM. Also
> > add partition information of SPI flash.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/da850-evm.dts |   40 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 40 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> > index 78c8e54..1a28d43 100644
> > --- a/arch/arm/boot/dts/da850-evm.dts
> > +++ b/arch/arm/boot/dts/da850-evm.dts
> > @@ -46,6 +46,46 @@
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&mmc0_pins>;
> >  		};
> > +		spi1: spi@1f0e000 {
> > +			status = "okay";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&spi1_pins>;
> > +			flash: m25p80@0 {
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				compatible = "m25p80";
> 
> Are you sure there is a m25p80 part on these boards? On my board using
> this patch I get:
> 
> m25p80 spi32766.0: found m25p64, expected m25p80
> 

On my board also I see this warning. Also there is mistake in filesystem
partition information specified in this patch, will correct it in next
version of patch.

Thanks,
Prakash

> I can access the flash just fine though.
> 
> Thanks,
> Sekhar
> 
