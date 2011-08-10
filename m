From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 3/6] spi/spi-pl022: Don't allocate more sg than
	required.
Date: Wed, 10 Aug 2011 09:54:31 +0100
Message-ID: <20110810085431.GD1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: pratyush.anand@st.com, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com,
	bhupesh.sharma@st.com, armando.visconti@st.com,
	linus.walleij@linaro.org, jassisinghbrar@gmail.com,
	vipin.kumar@st.com, grant.likely@secretlab.ca,
	shiraz.hashim@st.com, amit.virdi@st.com, vipulkumar.samar@st.com,
	viresh.linux@gmail.com, deepak.sikri@st.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 10, 2011 at 02:20:56PM +0530, Viresh Kumar wrote:
> In routine configure_dma(), if transfer->len = PAGE_SIZE, then pages is one more
> than required. While leads to one more sg getting allocated.
> 
> This is wrong. Correct this to allocate correct number of sg.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 80116be..1c8b9ec 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1016,7 +1016,8 @@ static int configure_dma(struct pl022 *pl022)
>  	dmaengine_slave_config(txchan, &tx_conf);
>  
>  	/* Create sglists for the transfers */
> -	pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
> +	pages = ((pl022->cur_transfer->len + (1 << PAGE_SHIFT) - 1)
> +			>> PAGE_SHIFT);

It would be far better for this to be:

	pages = DIV_ROUND_UP(pl022->cur_transfer->len, PAGE_SIZE);

The compiler will probably optimize it to the same code anyway.
