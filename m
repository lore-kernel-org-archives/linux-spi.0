From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] ARM: SPEAr: DT: Remove nonexistent properties
Date: Mon, 20 Mar 2017 16:35:16 +0530
Message-ID: <20170320110516.GG25659@vireshk-i7>
References: <20170320095721.6724-1-borneo.antonio@gmail.com>
 <20170320095721.6724-2-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijeshkumar.singh@amd.com>,
 Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org,
 Jon Mason <jonmason@broadcom.com>, Viresh Kumar <vireshk@kernel.org>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Mark Brown <broonie@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-spi@vger.kernel.org,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, linux-kernel@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170320095721.6724-2-borneo.antonio@gmail.com>
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

On 20-03-17, 10:57, Antonio Borneo wrote:
> The properties "pl022,hierarchy" and "pl022,slave-tx-disable" are
> not documented in DT binding and don't exist in the driver code.
> They have no effect and can be removed.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> To: Viresh Kumar <vireshk@kernel.org>
> To: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-spi@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm/boot/dts/spear1310-evb.dts | 6 ------
>  arch/arm/boot/dts/spear1340-evb.dts | 6 ------
>  2 files changed, 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
