From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
Date: Fri, 20 Nov 2015 10:03:46 -0600
Message-ID: <20151120160346.GA21921@rob-hp-laptop>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDJIP47K7MERB3UIXWZAKGQEIGPG5PY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447948422-4915-2-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 19, 2015 at 04:53:42PM +0100, Marcus Weseloh wrote:
> Adds support and documentation for a new slave device property
> "sun4i,spi-wdelay" that allows to set the SPI Wait Clock Register per
> device / transfer. The SPI hardware will wait the specified amount of
> SPI clock periods (plus a constant 3 clock periods) before transmitting
> the next word.
> 
> The constant additional 3 clock periods are not documented by the vendor
> and have been determined by analyzing the generated waveforms across
> many different transmission speeds.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-sun4i.txt | 11 +++++++++++
>  drivers/spi/spi-sun4i.c                             |  7 +++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> index de827f5..9c4d723 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> @@ -10,6 +10,10 @@ Required properties:
>    - "mod": the parent module clock
>  - clock-names: Must contain the clock names described just above
>  
> +Optional properties for slave devices:
> +- sun4i,spi-wdelay : delay between transmission of words, specified in number
> +  of SPI clock periods (actual delay is wdelay + 3 clock periods)

Seems like a common property to me. For a common one, it should be the 
actual delay and the driver needs to subtract the 3 clock periods here.

Rob
