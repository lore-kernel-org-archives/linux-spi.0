From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 4/4] ARM: davinci: da850-evm: add SPI flash support
Date: Mon, 4 Mar 2013 13:47:48 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48421@DBDE01.ent.ti.com>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
	<1362401955-9616-5-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
        "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
        "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
        "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org"
	<rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1362401955-9616-5-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
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

On Mon, Mar 04, 2013 at 18:29:15, Manjunathappa, Prakash wrote:
> Enable m25p64 SPI flash support on da850-EVM. Also
> add partition information of SPI flash.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
> ---
> Since v1:
> Look for m25p64 instead of m25p80.
> Corrected the filesystem partition information.
> 
>  arch/arm/boot/dts/da850-evm.dts |   40 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index c359872..3306d82 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -41,6 +41,46 @@
>  		wdt: wdt@1c21000 {
>  			status = "okay";
>  		};
> +		spi1: spi@1f0e000 {
> +			status = "okay";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi1_pins>;
> +			flash: m25p80@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "m25p64";
> +				spi-max-frequency = <30000000>;
> +				reg = <0>;
> +				partition@0 {
> +					label = "U-Boot-SPL";
> +					reg = <0x00000000 0x00010000>;
> +					read-only;
> +				};
> +				partition@1 {
> +					label = "U-Boot";
> +					reg = <0x00010000 0x00080000>;
> +					read-only;
> +				};
> +				partition@2 {
> +					label = "U-Boot-Env";
> +					reg = <0x00090000 0x00010000>;
> +					read-only;
> +				};
> +				partition@3 {
> +					label = "Kernel";
> +					reg = <0x000a0000 0x00280000>;
> +				};
> +				partition@4 {
> +					label = "Filesystem";
> +					reg = <0x00320000 0x00400000>;
> +				};
> +				partition@5 {
> +					label = "MAC-Address";
> +					reg = <0x00720000 0x00010000>;

Ah... MAC address is at the end of 8MB flash. Need to change above:
					reg = <0x007f0000 0x00010000>;
Will send v3 for this.

Thanks,
Prakash

> +					read-only;
> +				};
> +			};
> +		};
>  	};
>  	nand_cs3@62000000 {
>  		status = "okay";
> -- 
> 1.7.4.1
> 
> 
