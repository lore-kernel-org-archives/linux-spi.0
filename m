From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/8] hwspinlock: Add one new API to support getting a
 specific hwlock by the name
Date: Tue, 26 Jun 2018 13:54:39 -0700
Message-ID: <20180626205438.GG3206@builder>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ohad@wizery.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri 22 Jun 01:08 PDT 2018, Baolin Wang wrote:

> The hardware spinlock binding already supplied the 'hwlock-names' property
> to match and get a specific hwlock, but did not supply one API for users
> to get a specific hwlock by the hwlock name. So this patch introduces one
> API to support this requirement.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Thanks Baolin,

Picked up all but patch 6 from the series; including 7 and 8 with Mark's
ack.

Regards,
Bjorn

> ---
>  drivers/hwspinlock/hwspinlock_core.c |   29 +++++++++++++++++++++++++++++
>  include/linux/hwspinlock.h           |    7 +++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> index d16e6a3..bea3586 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -367,6 +367,35 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
>  }
>  EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id);
>  
> +/**
> + * of_hwspin_lock_get_id_byname() - get lock id for an specified hwlock name
> + * @np: device node from which to request the specific hwlock
> + * @name: hwlock name
> + *
> + * This function provides a means for DT users of the hwspinlock module to
> + * get the global lock id of a specific hwspinlock using the specified name of
> + * the hwspinlock device, so that it can be requested using the normal
> + * hwspin_lock_request_specific() API.
> + *
> + * Returns the global lock id number on success, -EPROBE_DEFER if the hwspinlock
> + * device is not yet registered, -EINVAL on invalid args specifier value or an
> + * appropriate error as returned from the OF parsing of the DT client node.
> + */
> +int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
> +{
> +	int index;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	index = of_property_match_string(np, "hwlock-names", name);
> +	if (index < 0)
> +		return index;
> +
> +	return of_hwspin_lock_get_id(np, index);
> +}
> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id_byname);
> +
>  static int hwspin_lock_register_single(struct hwspinlock *hwlock, int id)
>  {
>  	struct hwspinlock *tmp;
> diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
> index 57537e6..2b6f389 100644
> --- a/include/linux/hwspinlock.h
> +++ b/include/linux/hwspinlock.h
> @@ -66,6 +66,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
>  							unsigned long *);
>  int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
>  void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
> +int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
>  
>  #else /* !CONFIG_HWSPINLOCK */
>  
> @@ -125,6 +126,12 @@ static inline int hwspin_lock_get_id(struct hwspinlock *hwlock)
>  	return 0;
>  }
>  
> +static inline
> +int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
> +{
> +	return 0;
> +}
> +
>  #endif /* !CONFIG_HWSPINLOCK */
>  
>  /**
> -- 
> 1.7.9.5
> 
