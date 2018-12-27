From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 14/14] spi: stm32: add description about STM32F4
 bindings
Date: Thu, 27 Dec 2018 15:09:52 -0600
Message-ID: <20181227210952.GA26671@bogus>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
 <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: cezary.gapinski@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 24 Dec 2018 23:00:40 +0100, cezary.gapinski@gmail.com wrote:
> From: Cezary Gapinski <cezary.gapinski@gmail.com>
> 
> Add description that STM32F4 can be used in compatible property.
> Master Inter-Data Idleness optional property cannot be used in STM32F4.
> 
> Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
