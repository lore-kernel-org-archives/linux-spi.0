From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 05/12] spi: mxs-spi: move to use generic DMA helper
Date: Sat, 02 Mar 2013 23:17:37 +0000
Message-ID: <20130302231737.D2D743E36A2@localhost>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
 Huang Shijie <b32955@freescale.com>, Vinod Koul <vinod.koul@intel.com>,
 Marek Vasut <marek.vasut@gmail.com>, spi-devel-general@lists.sourceforge.net,
 Shawn Guo <shawn.guo@linaro.org>
To: Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1361978748-25281-6-git-send-email-shawn.guo@linaro.org>
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

On Wed, 27 Feb 2013 23:25:41 +0800, Shawn Guo <shawn.guo@linaro.org> wrote:
> With the generic DMA device tree helper supported by mxs-dma driver,
> client devices only need to call dma_request_slave_channel() for
> requesting a DMA channel from dmaengine.
> 
> Since mxs is a DT only platform now, along with the changes, the non-DT
> case handling in probe function also gets removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: spi-devel-general@lists.sourceforge.net

Acked-by: Grant Likely <grant.likely@secretlab.ca>
