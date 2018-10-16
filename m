From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: add stm32 qspi controller
Date: Tue, 16 Oct 2018 17:36:31 -0500
Message-ID: <20181016223631.GA19725@bogus>
References: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
 <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
To: Ludovic Barre <ludovic.Barre@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 5 Oct 2018 09:43:02 +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds the documentation of device tree bindings
> for the STM32 QSPI controller. It is a specialized communication
> interface targeting single, dual or quad SPI Flash memories (NOR/NAND).
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
