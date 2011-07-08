From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/6] dt: add empty of_property_read_u32[_array] for non-dt
Date: Fri, 8 Jul 2011 12:49:59 -0600
Message-ID: <20110708184959.GC9070@ponder.secretlab.ca>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
	<1310113654-25887-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: patches@linaro.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1310113654-25887-6-git-send-email-shawn.guo@linaro.org>
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

On Fri, Jul 08, 2011 at 04:27:33PM +0800, Shawn Guo wrote:
> The patch adds empty functions of_property_read_u32 and
> of_property_read_u32_array for non-dt build, so that drivers
> migrating to dt can save some '#ifdef CONFIG_OF'.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Applied, thanks, and added the string version.

> ---
>  include/linux/of.h |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4761046..4ef636e 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -255,5 +255,20 @@ static inline bool of_have_populated_dt(void)
>  	return false;
>  }
>  
> +static inline int of_property_read_u32_array(const struct device_node *np,
> +				      char *propname,
> +				      u32 *out_values,
> +				      size_t sz)
> +{
> +	return -ENOSYS;
> +}
> +
> +static inline int of_property_read_u32(const struct device_node *np,
> +				       char *propname,
> +				       u32 *out_value)
> +{
> +	return -ENOSYS;
> +}
> +
>  #endif /* CONFIG_OF */
>  #endif /* _LINUX_OF_H */
> -- 
> 1.7.4.1
> 
