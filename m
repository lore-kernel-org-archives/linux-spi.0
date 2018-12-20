From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/5] spi: stm32: add description about STM32F4 bindings
Date: Thu, 20 Dec 2018 13:49:11 -0600
Message-ID: <20181220194911.GA17409@bogus>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
 <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: cezary.gapinski@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun,  9 Dec 2018 14:53:56 +0100, cezary.gapinski@gmail.com wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
