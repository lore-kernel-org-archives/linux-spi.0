From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/2] spi/s3c64xx: Do not ignore return value of
 spi_master_resume/suspend
Date: Mon, 21 Oct 2013 15:50:42 +0200
Message-ID: <52653132.4090803@samsung.com>
References: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 21/10/13 15:42, Krzysztof Kozlowski wrote:
> During PM resume and suspend do not ignore the return value of
> spi_master_suspend() or spi_master_resume(). Instead pass it further.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
