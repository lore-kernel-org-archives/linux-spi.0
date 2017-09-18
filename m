From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: spi-davinci: Update binding for
 66AK2Gx pwr dm property
Date: Mon, 18 Sep 2017 14:29:49 -0500
Message-ID: <20170918192949.jm3s2mwvvyadl6y5@rob-hp-laptop>
References: <20170908204638.13149-1-fcooper@ti.com>
 <20170908204638.13149-2-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com, ssantosh@kernel.org,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170908204638.13149-2-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 08, 2017 at 03:46:36PM -0500, Franklin S Cooper Jr wrote:
> Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
> unique clocks property usage.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-davinci.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
