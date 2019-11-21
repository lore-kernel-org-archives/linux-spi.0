From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: spi: Convert stm32 QSPI bindings to
 json-schema
Date: Thu, 21 Nov 2019 08:38:55 -0600
Message-ID: <20191121143855.GA23685@bogus>
References: <20191120194444.10540-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191120194444.10540-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 20 Nov 2019 20:44:44 +0100, Benjamin Gaignard wrote:
> Convert the STM32 QSPI binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in version 2:
> - fix subject
> - remove useless minItems and maxItems
>  .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 47 ------------
>  .../devicetree/bindings/spi/st,stm32-qspi.yaml     | 83 ++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
