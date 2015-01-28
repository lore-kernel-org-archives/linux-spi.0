From: BhuvanChandra.DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH 4/7] spi: spi-fsl-dspi: avoid preparing the clock two times
Date: Wed, 28 Jan 2015 06:58:33 +0000
Message-ID: <1422428658040.88027@toradex.com>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-5-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150127130117.GU21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "B44548@freescale.com" <B44548@freescale.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150127130117.GU21293@sirena.org.uk>
Content-Language: en-IN
Content-ID: <2FBC3D3D0C135044B31BCFB8805A25B2@toradex.com>
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


On 01/27/2015 06:31 PM, Mark Brown wrote:
> On Tue, Jan 27, 2015 at 04:27:21PM +0530, Bhuvanchandra DV wrote:
>> regmap_read/regmap_write will expect the peripheral clock
>> to be enabled before accessing the registers of the peripheral.
>> Since the peripheral clock is enabled separatly, avoid redundant clock
>> prepare (with devm_regmap_init_mmio_clk) and use devm_regmap_init_mmio instead.
> What's the advantage of this?  The clock API is refcounted so there
> should be no issue with this and it seems like it's opening us up to
> bugs if there's a path where we interact with the registers without
> enabling the clocks.

My initial thought was that, since regmap_mmio_init_clk() does call
clk_prepare(), to go with regmap_mmio_init() as clk_prepare_enable()
is called at a later stage in the probe().
