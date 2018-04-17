From: andi@etezian.org
Subject: Re: [PATCH v2 7/8] spi: spi-s3c64xx: Use local variable for FIFO
 length
Date: Wed, 18 Apr 2018 03:14:35 +0900
Message-ID: <7eddeec03e4bb1eedaa2e068361e2c65@etezian.org>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143053epcas1p2a1bf34ea178d1f20fee3c6ade18bf17d@epcas1p2.samsung.com>
 <20180417142954.5507-7-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180417142954.5507-7-s.nawrocki@samsung.com>
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

Hi Sylwester,

On 17.04.2018 23:29, Sylwester Nawrocki wrote:
> More references to fifo_len are added in subsequent patch.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

thanks also for this! It's trivial, but I like it better
on a separate patch.

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi
