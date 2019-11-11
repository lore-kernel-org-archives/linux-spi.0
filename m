From: Tony Lindgren <tony@atomide.com>
Subject: Re: Applied "spi: add power control when set_cs" to the spi tree
Date: Mon, 11 Nov 2019 11:54:35 -0800
Message-ID: <20191111195435.GW5610@atomide.com>
References: <1572426234-30019-1-git-send-email-luhua.xu@mediatek.com>
 <20191031132342.100F1D020AA@fitzroy.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luhua Xu <luhua.xu@mediatek.com>, wsd_upstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191031132342.100F1D020AA@fitzroy.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

* Mark Brown <broonie@kernel.org> [191031 13:24]:
> The patch
> 
>    spi: add power control when set_cs
> 
> has been applied to the spi tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

This patch causes a regression for many SPI devices as they
assume spi_setup() return 0 on success and not a positive value.

I've sent a fix for this as:

spi: Fix regression to return zero on success instead of positive value

Regards,

Tony
