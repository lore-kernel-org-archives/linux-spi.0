From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/6] OF: Add [__]of_find_node_by_full_name
Date: Tue, 24 Jun 2014 14:55:23 +0100
Message-ID: <20140624135523.99956C40B84@trevor.secretlab.ca>
References: <1403430039-15085-1-git-send-email-pantelis.antoniou@konsulko.com>
	<1403430039-15085-3-git-send-email-pantelis.antoniou@konsulko.com>
	<53A86ADA.9000903@roeck-us.net>
	<4F4A55EC-744B-49CC-96FA-811C9483A43D@konsulko.com>
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
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pete Po
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4A55EC-744B-49CC-96FA-811C9483A43D-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 23 Jun 2014 21:00:39 +0300, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> wrote:
> Hi Guenter,
> 
> On Jun 23, 2014, at 8:58 PM, Guenter Roeck wrote:
> 
> > On 06/22/2014 02:40 AM, Pantelis Antoniou wrote:
> >> __of_find_node_by_full_name recursively searches for a matching node
> >> with the given full name without taking any locks.
> >> 
> >> of_find_node_by_full_name takes locks and takes a reference on the
> >> matching node.
> >> 
> >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> >> ---
> >>  drivers/of/base.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/of.h |  4 ++++
> >>  2 files changed, 62 insertions(+)
> >> 
> >> diff --git a/drivers/of/base.c b/drivers/of/base.c
> >> index d3493e1..80fef33 100644
> >> --- a/drivers/of/base.c
> >> +++ b/drivers/of/base.c
> >> @@ -1201,6 +1201,64 @@ static void *of_find_property_value_of_size(const struct device_node *np,
> >>  }
> >> 
> >>  /**
> >> + * __of_find_node_by_full_name - Find a node with the full name recursively
> >> + * @node:	Root of the tree to perform the search
> >> + * @full_name:	Full name of the node to find.
> >> + *
> >> + * Find a node with the give full name by recursively following any of
> >> + * the child node links.
> >> + * Returns the matching node, or NULL if not found.
> >> + * Note that the devtree lock is not taken, so this function is only
> >> + * safe to call on either detached trees, or when devtree lock is already
> >> + * taken.
> >> + */
> >> +struct device_node *__of_find_node_by_full_name(struct device_node *node,
> >> +		const char *full_name)
> >> +{
> >> +	struct device_node *child, *found;
> >> +
> >> +	if (node == NULL)
> >> +		return NULL;
> >> +
> >> +	/* check */
> >> +	if (of_node_cmp(node->full_name, full_name) == 0)
> >> +		return node;
> >> +
> >> +	__for_each_child_of_node(node, child) {
> >> +		found = __of_find_node_by_full_name(child, full_name);
> >> +		if (found != NULL)
> >> +			return found;
> >> +	}
> >> +
> >> +	return NULL;
> >> +}
> >> +EXPORT_SYMBOL(__of_find_node_by_full_name);
> >> +
> >> +/**
> >> + * of_find_node_by_full_name - Find a node with the full name recursively
> >> + * @node:	Root of the tree to perform the search
> >> + * @full_name:	Full name of the node to find.
> >> + *
> >> + * Find a node with the give full name by recursively following any of
> >> + * the child node links.
> >> + * Returns the matching node (with a ref taken), or NULL if not found.
> >> + */
> >> +struct device_node *of_find_node_by_full_name(struct device_node *node,
> >> +		const char *full_name)
> >> +{
> >> +	unsigned long flags;
> >> +	struct device_node *np;
> >> +
> >> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> >> +	np = of_find_node_by_full_name(node, full_name);
> > 
> > Should this be __of_find_node_by_full_name, or am I missing something ?
> > 
> 
> Ugh, you're not missing something. This slipped through since this is not 
> used in the current code

Then perhaps the function shouldn't exist at all.

g.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
