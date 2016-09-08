From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
Date: Thu, 8 Sep 2016 14:04:40 +0200
Message-ID: <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: broonie@kernel.org, carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Neil Armstrong <narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 08.09.2016 um 09:53 schrieb Neil Armstrong:
> This patchset adds a specific compatible string in the Meson SPIFC driver for
> the Amlogic Meson GXBB SoC.

Any particular reason? We could just reuse the meson6 one since there
appear to be no code changes so far.

Regards,
Andreas

> This patchset is SPI-only respin from Jerome Brunet patchset at [1].
> 
> [1] http://lkml.kernel.org/r/1473261223-15412-1-git-send-email-jbrunet@baylibre.com
> 
> Neil Armstrong (2):
>   dt-bindings: spi-meson: Add GXBB Compatible string
>   spi: meson: Add GXBB compatible
> 
>  Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
>  drivers/spi/spi-meson-spifc.c                       | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
