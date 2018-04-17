From: andi@etezian.org
Subject: Re: [PATCH v2 4/8] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
Date: Wed, 18 Apr 2018 03:09:39 +0900
Message-ID: <749a25fcaf0ccaed931244dc8d381b98@etezian.org>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143039epcas2p39e2c730d107c94e5f9bf104d3a938f90@epcas2p3.samsung.com>
 <20180417142954.5507-4-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180417142954.5507-4-s.nawrocki@samsung.com>
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
> The spi pointer argument is not used now so remove it.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thanks for splitting it!

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi
