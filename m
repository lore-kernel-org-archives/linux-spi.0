From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH -next] spi: bcm2835aux: remove unneeded NULL check of
 devm_clk_get
Date: Wed, 23 Jan 2019 17:16:05 +0100 (CET)
Message-ID: <2064917135.710926.1548260165940@email.ionos.de>
References: <20190123070507.15404-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org, eric@anholt.net,
 f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190123070507.15404-1-yuehaibing@huawei.com>
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

> YueHaibing <yuehaibing@huawei.com> hat am 23. Januar 2019 um 08:05 geschrieben:
> 
> 
> Fix a static code checker warning:
> drivers/spi/spi-bcm2835aux.c:460
>  bcm2835aux_spi_probe() warn: passing zero to 'PTR_ERR'
> 
> In case of error, the function devm_clk_get() returns ERR_PTR()
> and not returns NULL.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
