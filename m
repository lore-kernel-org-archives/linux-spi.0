From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/6] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
Date: Tue, 17 Apr 2018 08:28:46 +0200
Message-ID: <CAJKOXPfJcJ2pP=whPj-i55MMr6eZSsR+B0AUXG9ZFyynrO0FbA@mail.gmail.com>
References: <CGME20180416154122epcas1p1ae714af12f8da08783c47fcd820c40e7@epcas1p1.samsung.com>
 <20180416154021.25626-1-s.nawrocki@samsung.com>
 <20180416154021.25626-3-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, linux-spi@vger.kernel.org, broonie@kernel.org,
 kgene@kernel.org, Andi Shyti <andi@etezian.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180416154021.25626-3-s.nawrocki@samsung.com>
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

On Mon, Apr 16, 2018 at 5:40 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The spi pointer argument is not used now so remove it. While at it
> s3c64xx_ prefix is added to the function name.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
