From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: spi: Convert stm32 spi bindings to
 json-schema
Date: Tue, 17 Dec 2019 17:57:36 -0600
Message-ID: <20191217235736.GA17096@bogus>
References: <20191217090715.13334-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Erwan Leray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191217090715.13334-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 17 Dec 2019 10:07:15 +0100, Benjamin Gaignard wrote:
> Convert the STM32 spi binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Erwan Leray <erwan.leray@st.com>
> CC: Fabrice Gasnier <fabrice.gasnier@st.com>
> CC: Amelie Delaunay <amelie.delaunay@st.com>
> ---
> changes in version 2:
> - fix typo in if block (compatible + contains)
>   The boths typos weren't detected by checkpatch.
> - remove type for st,spi-midi-ns property but not add upper limit
>   because the driver compute a delay (expressed in SPI clock cycles periods)
>   from this value (expressed in nanoseconds) and all that depends of the SPI
>   bus clock.
>  .../devicetree/bindings/spi/spi-stm32.txt          |  62 ------------
>  .../devicetree/bindings/spi/st,stm32-spi.yaml      | 105 +++++++++++++++++++++
>  2 files changed, 105 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
