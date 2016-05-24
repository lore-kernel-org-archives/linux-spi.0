From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Tue, 24 May 2016 18:41:41 +0100
Message-ID: <20160524174140.GE11605@leverpostej>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Christer Weinigel <christer@weinigel.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464107960-10775-1-git-send-email-christer@weinigel.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
> Document how to use devicetree aliases to assign a stable
> bus number to a spi bus.
> 
> Signed-off-by: Christer Weinigel <christer@weinigel.se>
> 
> ---
> 
> Trivial documentation change.
> 
> Not having used devicetree that much it was surprisingly hard to
> figure out how to assign a stable bus number to a spi bus.  Add a
> simple example that shows how to do that.
> 
> Mark Cced as the SPI maintainer.  Or should trivial documentation
> fixes like this be addressed to someone else?
> 
>   /Christer
> 
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 42d5954..c35c4c2 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -94,3 +94,13 @@ SPI example for an MPC5200 SPI bus:
>  			reg = <1>;
>  		};
>  	};
> +
> +Normally SPI buses are assigned dynamic bus numbers starting at 32766
> +and counting downwards.  It is possible to assign the bus number
> +statically using devicetee aliases.  For example, on the MPC5200 the
> +"spi@f00" device above is connected to the "soc" bus.  To set its
> +bus_num to 1 add an aliases entry like this:

As Mark Brown pointed out, this is very Linux-specific (at least in the
wording of the above).

Generally, aliases are there to match _physical_ identifiers (e.g. to
match physical labels for UART0, UART1, and on).

I'm not sure whether that applies here.

Thanks,
Mark.
