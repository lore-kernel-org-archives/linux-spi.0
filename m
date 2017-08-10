From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 14/23] spi: rockchip: add compatible string for rv1108
 spi
Date: Thu, 10 Aug 2017 11:15:23 -0500
Message-ID: <20170810161523.vzmlgrmnex7yyepy@rob-hp-laptop>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
 <1501663563-12482-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501663563-12482-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 02, 2017 at 04:46:03PM +0800, Andy Yan wrote:
> The spi on rv1108 is the same as other rockchip based
> socs, add compatible string for it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
>  drivers/spi/spi-rockchip.c                             | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
