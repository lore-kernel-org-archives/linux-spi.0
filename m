From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH] arm64: dts: hi6220: enable DMA in spi0
Date: Tue, 21 Mar 2017 20:13:29 +0100
Message-ID: <CAAj6DX3kvc-wy+xSPBC26Xw0s6BBApTJQGrVS1BsiFgfDybBbw@mail.gmail.com>
References: <20170321070818.3247-1-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Zhong Kaihua <zhongkaihua@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 xuwei5@hisilicon.com, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org
To: Guodong Xu <guodong.xu@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170321070818.3247-1-guodong.xu@linaro.org>
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

On Tue, Mar 21, 2017 at 8:08 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>
> Enable DMA in spi0.

Hi Guodong, Xiaoyin,

added linux-spi in copy.

Actually the patch does not enable the DMA. The commit message is not correct.

> Cc: Antonio Borneo <borneo.antonio@gmail.com>
> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 470461d..e40625f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -682,7 +682,8 @@
>                         reg = <0x0 0xf7106000 0x0 0x1000>;
>                         interrupts = <0 50 4>;
>                         bus-id = <0>;
> -                       enable-dma = <0>;
> +                       dmas =  <&dma0 0 &dma0 1>;
> +                       dma-names = "rx", "tx";

The controller spi0 is a standard ARM PL022.
This patch removes the nonexistent property "enable-dma" and specifies
which DMA controller and which DMA channels are connected to spi0.
The values are coherent with the documentation available for hi6220.

Apart from the commit message, I'm fine with this patch.

On PL022 the DMA is not enabled in the DT node of the controller but
in the DT node of each spi device, through the property
"pl022,com-mode".
A separate patch should eventually enable the DMA for those spi
devices that require it.

Best Regards,
Antonio

>                         clocks = <&sys_ctrl HI6220_SPI_CLK>;
>                         clock-names = "apb_pclk";
>                         pinctrl-names = "default";
> --
> 2.10.2
>
