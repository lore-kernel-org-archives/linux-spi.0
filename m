From: andi@etezian.org
Subject: Re: [PATCH 2/6] spi: spi-s3c64xx: Remove unused s3c64xx_spi_hwinit()
 function argument
Date: Tue, 17 Apr 2018 04:06:31 +0900
Message-ID: <d4ccf19bd88c45c50f4026d6e08951c7@etezian.org>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154109epcas2p1696b9cdc72403fe5abdd0a2117067c8d@epcas2p1.samsung.com>
 <20180416154021.25626-2-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180416154021.25626-2-s.nawrocki@samsung.com>
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

On 17.04.2018 00:40, Sylwester Nawrocki wrote:
> The channel argument is not used and anyway it could be retrieved from
> the passed driver data structure.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
