From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/6] spi: spi-s3c64xx: Remove unused driver data structure
 tgl_spi field
Date: Tue, 17 Apr 2018 08:27:27 +0200
Message-ID: <CAJKOXPcSJoDLAK5VnPbqDq7zVPxr1NCTdd+e8WfTgyOAw=2CYg@mail.gmail.com>
References: <CGME20180416154055epcas2p4c08bb2254e79368a29eb481cddc59855@epcas2p4.samsung.com>
 <20180416154021.25626-1-s.nawrocki@samsung.com>
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
In-Reply-To: <20180416154021.25626-1-s.nawrocki@samsung.com>
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
> The tgl_spi pointer is now unused so remove it.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
