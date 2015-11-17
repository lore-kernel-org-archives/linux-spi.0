From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] SPI: s3c64xx: pass DMA arguments in platform data
Date: Tue, 17 Nov 2015 11:33:45 +0100
Message-ID: <16591294.iqvGkiFfez@wuerfel>
References: <8391350.6B0EUH1WXO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <8391350.6B0EUH1WXO@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday 16 November 2015 17:00:21 Arnd Bergmann wrote:
> The s3c64xx platform data already contains a pointer to the
> DMA filter function, but not to the associated data.
> 
> This simplifies the code and makes it more generic by
> passing the data along with the filter function like
> we do for other drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

While rebasing the ASoC patches, I realized that they are not independent
of this one, which I did on top of the others.

None of them are urgent, so if the maintainers all agree that we want them,
I can wait another merge window with this one. Alternatively, I could
rework the patches to avoid the dependency, or we could merge them
all through the samsung git tree in order.

	Arnd
