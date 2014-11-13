From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v8 4/8] OF: platform: Add OF notifier handler
Date: Thu, 13 Nov 2014 23:29:44 +0000
Message-ID: <20141113232944.1F136C40B52@trevor.secretlab.ca>
References: <1414528565-10907-1-git-send-email-pantelis.antoniou@konsulko.com>
	<1414528565-10907-5-git-send-email-pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>,
	Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>,
	Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414528565-10907-5-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 28 Oct 2014 22:36:01 +0200
, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
 wrote:
> Add OF notifier handler needed for creating/destroying platform devices
> according to dynamic runtime changes in the DT live tree.
> 
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Hi Pantelis,

Some comments below. Feel free to send me fixup patches instead of
respinning.

g.

> ---
>  drivers/base/platform.c     | 18 +++++++++--
>  drivers/of/platform.c       | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_platform.h | 10 ++++++
>  3 files changed, 103 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b2afc29..282bfec 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1002,10 +1002,22 @@ int __init platform_bus_init(void)
>  
>  	error = device_register(&platform_bus);
>  	if (error)
> -		return error;
> -	error =  bus_register(&platform_bus_type);
> +		goto err_out;
> +
> +	error = bus_register(&platform_bus_type);
> +	if (error)
> +		goto err_unreg_dev;
> +
> +	error = of_platform_register_reconfig_notifier();
>  	if (error)
> -		device_unregister(&platform_bus);
> +		goto err_unreg_bus;

We really don't want to fail out here. If the notifier registration fails, it
doesn't make sense to cause the entire boot to fail.

Instead of refactoring the function, just add the call to
of_platform_register_reconfig_notifier(), and WARN_ON() failure without
bailing.

(Actually, you don't need to send me a fixup for this; I've gone ahead
and fixed it up in my tree)

> +
> +	return 0;
> +err_unreg_bus:
> +	bus_unregister(&platform_bus_type);
> +err_unreg_dev:
> +	device_unregister(&platform_bus);
> +err_out:
>  	return error;
>  }
>  
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 3b64d0b..aa8db92 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -546,4 +546,82 @@ void of_platform_depopulate(struct device *parent)
>  }
>  EXPORT_SYMBOL_GPL(of_platform_depopulate);
>  
> +#ifdef CONFIG_OF_DYNAMIC
> +
> +static struct notifier_block platform_of_notifier;
> +
> +static int of_platform_notify(struct notifier_block *nb,
> +				unsigned long action, void *arg)
> +{
> +	struct platform_device *pdev_parent, *pdev;
> +	struct device_node *dn;
> +	int state;
> +	bool children_left;
> +
> +	state = of_reconfig_get_state_change(action, arg);
> +
> +	/* no change? */
> +	if (state == -1)
> +		return NOTIFY_OK;
> +
> +	switch (action) {
> +	case OF_RECONFIG_ATTACH_NODE:
> +	case OF_RECONFIG_DETACH_NODE:
> +		dn = arg;
> +		break;
> +	case OF_RECONFIG_ADD_PROPERTY:
> +	case OF_RECONFIG_REMOVE_PROPERTY:
> +	case OF_RECONFIG_UPDATE_PROPERTY:
> +		dn = ((struct of_prop_reconfig *)arg)->dn;
> +		break;
> +	default:
> +		return NOTIFY_OK;
> +	}
> +
> +	if (state) {
> +
> +		/* verify that the parent is a bus */
> +		if (!of_match_node(of_default_bus_match_table, dn->parent))
> +			return NOTIFY_OK;	/* not for us */

This doesn't work reliably. Not all callers of of_platform_populate use
the of_default_bus_match_table. The code needs to actively track the
nodes that were used to create child devices. We've got a flag in the
device node now that you can use for that; OF_POPULATED_BUS.

> +
> +		/* pdev_parent may be NULL when no bus platform device */
> +		pdev_parent = of_find_device_by_node(dn->parent);
> +		pdev = of_platform_device_create(dn, NULL,
> +				pdev_parent ? &pdev_parent->dev : NULL);
> +		of_dev_put(pdev_parent);
> +
> +		if (pdev == NULL) {
> +			pr_err("%s: failed to create for '%s'\n",
> +					__func__, dn->full_name);
> +			/* of_platform_device_create tosses the error code */
> +			return notifier_from_errno(-EINVAL);
> +		}
> +
> +	} else {
> +
> +		/* find our device by node */
> +		pdev = of_find_device_by_node(dn);
> +		if (pdev == NULL)
> +			return NOTIFY_OK;	/* no? not meant for us */
> +
> +		/* unregister takes one ref away */
> +		of_platform_device_destroy(&pdev->dev, &children_left);
> +
> +		/* and put the reference of the find */
> +		of_dev_put(pdev);
> +
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +int of_platform_register_reconfig_notifier(void)
> +{
> +	platform_of_notifier.notifier_call = of_platform_notify;
> +	return of_reconfig_notifier_register(&platform_of_notifier);
> +}
> +EXPORT_SYMBOL_GPL(of_platform_register_reconfig_notifier);
> +
> +#endif
> +
>  #endif /* CONFIG_OF_ADDRESS */
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index c2b0627..01fe5d6 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -84,4 +84,14 @@ static inline int of_platform_populate(struct device_node *root,
>  static inline void of_platform_depopulate(struct device *parent) { }
>  #endif
>  
> +#ifdef CONFIG_OF_DYNAMIC
> +extern int of_platform_register_reconfig_notifier(void);
> +#else
> +static inline int of_platform_register_reconfig_notifier(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +
>  #endif	/* _LINUX_OF_PLATFORM_H */
> -- 
> 1.7.12
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
