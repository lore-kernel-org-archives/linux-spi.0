From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
Date: Thu, 14 Nov 2019 14:27:15 +0800
Message-ID: <CAJKOXPe_vfDjJSbVOxFFDFO3OWPLFr_UffCqVZb4ahGF57aVYA@mail.gmail.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linus.walleij@linaro.org, kgene@kernel.org, alexandre.belloni@bootlin.com,
 linux-arm-msm@vger.kernel.org, radu_nicolae.pirea@upb.ro,
 linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 bjorn.andersson@linaro.org, vkoul@kernel.org, agross@kernel.org,
 ldewangan@nvidia.com, broonie@kernel.org, Andi Shyti <andi@etezian.org>,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191113094256.1108-8-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Wed, 13 Nov 2019 at 17:42, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
>         dma_request_chan(dev, name)
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
