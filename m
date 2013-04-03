From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH v4 3/5] ARM: davinci: da850: add SPI1 DT node
Date: Wed, 3 Apr 2013 12:13:02 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4C066@DBDE01.ent.ti.com>
References: <1363776419-10563-1-git-send-email-prakash.pm@ti.com>
 <1363776419-10563-4-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"rob@landley.net" <rob@landley.net>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"Nori, Sekhar" <nsekhar@ti.com>, "hs@denx.de" <hs@denx.de>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>,
	"davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1363776419-10563-4-git-send-email-prakash.pm@ti.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Wed, Mar 20, 2013 at 16:16:57, Manjunathappa, Prakash wrote:
> Patch adds SPI1 DT node along with pinmux data.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  arch/arm/boot/dts/da850.dtsi |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 3ec1bda..327fb06 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -62,6 +62,14 @@
>  					0x10 0x00002200 0x0000ff00
>  				>;
>  			};
> +			spi1_pins: pinmux_spi_pins {
> +				pinctrl-single,bits = <
> +					/* SIMO, SOMI, ENA,
> +					 * CLK, CS[0], CS[1]
> +					 */
> +					0x14 0x00111111 0x00ffffff

Since chip select is specific to a board, let me separate it out so as to
allow boards choose accordingly.

Thanks,
Prakash
