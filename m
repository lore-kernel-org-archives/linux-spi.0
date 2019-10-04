From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/7] dt-bindings: watchdog: renesas-wdt: Document r8a774b1
 support
Date: Fri, 4 Oct 2019 06:12:18 -0700
Message-ID: <eabf732e-33ba-8011-2cbc-f1df1f6dadb3@roeck-us.net>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/4/19 1:35 AM, Fabrizio Castro wrote:
> RZ/G2N (a.k.a. R8A774B1) watchdog implementation is compatible
> with R-Car Gen3, therefore add the relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/renesas,wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
> index 9f365c1..a5bf04d 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
> @@ -10,6 +10,7 @@ Required properties:
>   		 - "renesas,r8a7745-wdt" (RZ/G1E)
>   		 - "renesas,r8a77470-wdt" (RZ/G1C)
>   		 - "renesas,r8a774a1-wdt" (RZ/G2M)
> +		 - "renesas,r8a774b1-wdt" (RZ/G2N)
>   		 - "renesas,r8a774c0-wdt" (RZ/G2E)
>   	         - "renesas,r8a7790-wdt" (R-Car H2)
>   	         - "renesas,r8a7791-wdt" (R-Car M2-W)
> 
