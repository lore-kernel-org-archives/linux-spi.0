From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 1/6] spi/spi-pl022: Resolve formatting issues
Date: Tue, 20 Sep 2011 11:17:06 -0600
Message-ID: <20110920171706.GA7781@ponder.secretlab.ca>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<a72e7189be95278b97614fe9ab7d307d422d54e4.1312965741.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: pratyush.anand@st.com, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com,
	bhupesh.sharma@st.com, armando.visconti@st.com,
	linus.walleij@linaro.org, jassisinghbrar@gmail.com,
	vipin.kumar@st.com, shiraz.hashim@st.com, amit.virdi@st.com,
	vipulkumar.samar@st.com, viresh.linux@gmail.com,
	deepak.sikri@st.com, spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a72e7189be95278b97614fe9ab7d307d422d54e4.1312965741.git.viresh.kumar@st.com>
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

On Wed, Aug 10, 2011 at 02:20:54PM +0530, Viresh Kumar wrote:
> There were few formatting related issues in code. This patch fixes them.
> Fixes include:
> - Remove extra blank lines
> - align code to 80 cols
> - combine several lines to one line
> - Replace multiple spaces with tabs
> - Remove spaces before labels
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> @@ -2243,23 +2233,23 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  	amba_vcore_disable(adev);
>  	return 0;
>  
> - err_spi_register:
> - err_start_queue:
> - err_init_queue:
> +err_spi_register:
> +err_start_queue:
> +err_init_queue:
>  	destroy_queue(pl022);
>  	pl022_dma_remove(pl022);
>  	free_irq(adev->irq[0], pl022);
>  	pm_runtime_disable(&adev->dev);
> - err_no_irq:
> +err_no_irq:
>  	clk_put(pl022->clk);
> - err_no_clk:
> +err_no_clk:
>  	iounmap(pl022->virtbase);
> - err_no_ioremap:
> +err_no_ioremap:
>  	amba_release_regions(adev);
> - err_no_ioregion:
> +err_no_ioregion:
>  	spi_master_put(master);
> - err_no_master:
> - err_no_pdata:
> +err_no_master:
> +err_no_pdata:

These label indentations are actually on purpose.  I'll apply the rest
of the patch, but I'm going to remove this hunk.  Indenting error
labels by 1 space makes 'diff' show the function name instead of the
label in the context line.

g.
