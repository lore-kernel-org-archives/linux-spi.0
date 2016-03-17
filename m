From: Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v2 1/2] dt/bindings: Add bindings for PIC32 SPI
 peripheral
Date: Thu, 17 Mar 2016 07:00:42 -0500
Message-ID: <20160317120042.GA4744@rob-hp-laptop>
References: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Joshua Henderson <digitalpeer@digitalpeer.com>,
	devicetree@vger.kernel.org, linux-mips@linux-mips.org,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
To: Purna Chandra Mandal <purna.mandal@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Mar 06, 2016 at 10:05:26AM +0530, Purna Chandra Mandal wrote:
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> 
> ---
> 
> Changes in v2:
>  - fix indentation
>  - add space after comma
>  - moved 'cs-gpios' section under 'required' properties.
> 
>  .../bindings/spi/microchip,spi-pic32.txt           | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

Acked-by: Rob Herring <robh@kernel.org>
