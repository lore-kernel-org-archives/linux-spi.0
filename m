From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH v7 1/9] OF: Introduce Device Tree resolve support.
Date: Wed, 1 Oct 2014 19:51:35 +0300
Message-ID: <5113283C-6161-4EAB-B77E-47F502E54078@antoniou-consulting.com>
References: <1404493168-8980-1-git-send-email-pantelis.antoniou@konsulko.com> <1404493168-8980-2-git-send-email-pantelis.antoniou@konsulko.com> <20141001124644.24E1FC40755@trevor.secretlab.ca>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141001124644.24E1FC40755-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Oct 1, 2014, at 3:46 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wr=
ote:

> On Fri,  4 Jul 2014 19:59:20 +0300
> , Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> wrote:
>> Introduce support for dynamic device tree resolution.
>> Using it, it is possible to prepare a device tree that's
>> been loaded on runtime to be modified and inserted at the kernel
>> live tree.
>>=20
>> Export of of_resolve and bug fix of double free by
>> 	Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>=20
> Hi Pantelis,
>=20
> I suspect you've got a slightly updated version of this patch not pos=
ted
> yet, but I do have a few comments. Overall they're pretty minor.
>=20

Last time I checked (circa rc2), the last patch set applied. I=92ll hav=
e to rebase and=20
take a look again but I don=92t expect major changes.

>> ---
>> .../devicetree/dynamic-resolution-notes.txt        |  25 ++
>> drivers/of/Kconfig                                 |   6 +
>> drivers/of/Makefile                                |   1 +
>> drivers/of/resolver.c                              | 403 +++++++++++=
++++++++++
>> include/linux/of.h                                 |  16 +
>> 5 files changed, 451 insertions(+)
>> create mode 100644 Documentation/devicetree/dynamic-resolution-notes=
=2Etxt
>> create mode 100644 drivers/of/resolver.c
>>=20
>> diff --git a/Documentation/devicetree/dynamic-resolution-notes.txt b=
/Documentation/devicetree/dynamic-resolution-notes.txt
>> new file mode 100644
>> index 0000000..0b396c4
>> --- /dev/null
>> +++ b/Documentation/devicetree/dynamic-resolution-notes.txt
>> @@ -0,0 +1,25 @@
>> +Device Tree Dynamic Resolver Notes
>> +----------------------------------
>> +
>> +This document describes the implementation of the in-kernel
>> +Device Tree resolver, residing in drivers/of/resolver.c and is a
>> +companion document to Documentation/devicetree/dt-object-internal.t=
xt[1]
>> +
>> +How the resolver works
>> +----------------------
>> +
>> +The resolver is given as an input an arbitrary tree compiled with t=
he
>> +proper dtc option and having a /plugin/ tag. This generates the
>> +appropriate __fixups__ & __local_fixups__ nodes as described in [1]=
=2E
>> +
>> +In sequence the resolver works by the following steps:
>> +
>> +1. Get the maximum device tree phandle value from the live tree + 1=
=2E
>> +2. Adjust all the local phandles of the tree to resolve by that amo=
unt.
>> +3. Using the __local__fixups__ node information adjust all local re=
ferences
>> +   by the same amount.
>> +4. For each property in the __fixups__ node locate the node it refe=
rences
>> +   in the live tree. This is the label used to tag the node.
>> +5. Retrieve the phandle of the target of the fixup.
>> +5. For each fixup in the property locate the node:property:offset l=
ocation
>> +   and replace it with the phandle value.
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 2dcb054..0236a4e 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -78,4 +78,10 @@ config OF_RESERVED_MEM
>> 	help
>> 	  Helpers to allow for reservation of memory regions
>>=20
>> +config OF_RESOLVE
>> +	bool
>> +	depends on OF && !SPARC
>=20
> What part of this code breaks on SPARC?
>=20

There are some extra properties on the SPARC device nodes, which I don=92=
t know exactly how they work.
I don=92t have access to a SPARC box, lest I break something this condi=
tional.

>> +	select OF_DYNAMIC
>> +	select OF_DEVICE
>=20
> This code doesn't appear to depend on either OF_DYNAMIC or OF_DEVICE.=
 You
> should be able to drop the above 2 selects (at least it worked when I
> tried it here)
>=20

Yes, good catch. It wouldn=92t work of-course since all the calls to in=
sert nodes would
fail.

>> +
>> endmenu # OF
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index 9a68cc9..35a148a 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_OF_PCI)	+=3D of_pci.o
>> obj-$(CONFIG_OF_PCI_IRQ)  +=3D of_pci_irq.o
>> obj-$(CONFIG_OF_MTD)	+=3D of_mtd.o
>> obj-$(CONFIG_OF_RESERVED_MEM) +=3D of_reserved_mem.o
>> +obj-$(CONFIG_OF_RESOLVE)  +=3D resolver.o
>>=20
>> CFLAGS_fdt.o =3D -I$(src)/../../scripts/dtc/libfdt
>> CFLAGS_fdt_address.o =3D -I$(src)/../../scripts/dtc/libfdt
>> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
>> new file mode 100644
>> index 0000000..18da5ca
>> --- /dev/null
>> +++ b/drivers/of/resolver.c
>> @@ -0,0 +1,403 @@
>> +/*
>> + * Functions for dealing with DT resolution
>> + *
>> + * Copyright (C) 2012 Pantelis Antoniou <panto@antoniou-consulting.=
com>
>> + * Copyright (C) 2012 Texas Instruments Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/string.h>
>> +#include <linux/ctype.h>
>> +#include <linux/errno.h>
>> +#include <linux/string.h>
>> +#include <linux/slab.h>
>> +
>> +/**
>> + * Find a node with the give full name by recursively following any=
 of
>> + * the child node links.
>> + */
>> +static struct device_node *__of_find_node_by_full_name(struct devic=
e_node *node,
>> +		const char *full_name)
>> +{
>> +	struct device_node *child, *found;
>> +
>> +	if (node =3D=3D NULL)
>> +		return NULL;
>> +
>> +	/* check */
>> +	if (of_node_cmp(node->full_name, full_name) =3D=3D 0)
>> +		return node;
>> +
>> +	for_each_child_of_node(node, child) {
>> +		found =3D __of_find_node_by_full_name(child, full_name);
>> +		if (found !=3D NULL)
>> +			return found;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Find live tree's maximum phandle value.
>> + */
>> +static phandle of_get_tree_max_phandle(void)
>> +{
>> +	struct device_node *node;
>> +	phandle phandle;
>> +	unsigned long flags;
>> +
>> +	/* now search recursively */
>> +	raw_spin_lock_irqsave(&devtree_lock, flags);
>> +	phandle =3D 0;
>> +	for_each_of_allnodes(node) {
>> +		if (node->phandle !=3D OF_PHANDLE_ILLEGAL &&
>> +				node->phandle > phandle)
>> +			phandle =3D node->phandle;
>> +	}
>> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +
>> +	return phandle;
>> +}
>> +
>> +/*
>> + * Adjust a subtree's phandle values by a given delta.
>> + * Makes sure not to just adjust the device node's phandle value,
>> + * but modify the phandle properties values as well.
>> + */
>> +static void __of_adjust_tree_phandles(struct device_node *node,
>> +		int phandle_delta)
>> +{
>> +	struct device_node *child;
>> +	struct property *prop;
>> +	phandle phandle;
>> +
>> +	/* first adjust the node's phandle direct value */
>> +	if (node->phandle !=3D 0 && node->phandle !=3D OF_PHANDLE_ILLEGAL)
>> +		node->phandle +=3D phandle_delta;
>> +
>> +	/* now adjust phandle & linux,phandle values */
>> +	for_each_property_of_node(node, prop) {
>> +
>> +		/* only look for these two */
>> +		if (of_prop_cmp(prop->name, "phandle") !=3D 0 &&
>> +		    of_prop_cmp(prop->name, "linux,phandle") !=3D 0)
>> +			continue;
>> +
>> +		/* must be big enough */
>> +		if (prop->length < 4)
>> +			continue;
>> +
>> +		/* read phandle value */
>> +		phandle =3D be32_to_cpup(prop->value);
>> +		if (phandle =3D=3D OF_PHANDLE_ILLEGAL)	/* unresolved */
>> +			continue;
>> +
>> +		/* adjust */
>> +		*(uint32_t *)prop->value =3D cpu_to_be32(node->phandle);
>> +	}
>> +
>> +	/* now do the children recursively */
>> +	for_each_child_of_node(node, child)
>> +		__of_adjust_tree_phandles(child, phandle_delta);
>> +}
>> +
>> +/*
>> + * Adjust the local phandle references by the given phandle delta.
>> + * Assumes the existances of a __local_fixups__ node at the root
>> + * of the tree. Does not take any devtree locks so make sure you
>> + * call this on a tree which is at the detached state.
>> + */
>> +static int __of_adjust_tree_phandle_references(struct device_node *=
node,
>> +		int phandle_delta)
>> +{
>> +	phandle phandle;
>> +	struct device_node *refnode, *child;
>> +	struct property *rprop, *sprop;
>> +	char *propval, *propcur, *propend, *nodestr, *propstr, *s;
>> +	int offset, propcurlen;
>> +	int err;
>> +
>> +	/* locate the symbols & fixups nodes on resolve */
>> +	for_each_child_of_node(node, child)
>> +		if (of_node_cmp(child->name, "__local_fixups__") =3D=3D 0)
>> +			break;
>> +
>> +	/* no local fixups */
>> +	if (!child)
>> +		return 0;
>> +
>> +	/* find the local fixups property */
>> +	for_each_property_of_node(child, rprop) {
>> +
>> +		/* skip properties added automatically */
>> +		if (of_prop_cmp(rprop->name, "name") =3D=3D 0)
>> +			continue;
>> +
>=20
> Everything below this line....
>=20
>> +		/* make a copy */
>> +		propval =3D kmalloc(rprop->length, GFP_KERNEL);
>> +		if (!propval) {
>> +			pr_err("%s: Could not copy value of '%s'\n",
>> +					__func__, rprop->name);
>> +			return -ENOMEM;
>> +		}
>> +		memcpy(propval, rprop->value, rprop->length);
>> +
>> +		propend =3D propval + rprop->length;
>> +		for (propcur =3D propval; propcur < propend;
>> +				propcur +=3D propcurlen + 1) {
>> +
>> +			propcurlen =3D strlen(propcur);
>> +
>> +			nodestr =3D propcur;
>> +			s =3D strchr(propcur, ':');
>> +			if (!s) {
>> +				pr_err("%s: Illegal symbol entry '%s' (1)\n",
>> +					__func__, propcur);
>> +				err =3D -EINVAL;
>> +				goto err_fail;
>> +			}
>> +			*s++ =3D '\0';
>> +
>> +			propstr =3D s;
>> +			s =3D strchr(s, ':');
>> +			if (!s) {
>> +				pr_err("%s: Illegal symbol entry '%s' (2)\n",
>> +					__func__, (char *)rprop->value);
>> +				err =3D -EINVAL;
>> +				goto err_fail;
>> +			}
>> +
>> +			*s++ =3D '\0';
>> +			err =3D kstrtoint(s, 10, &offset);
>> +			if (err !=3D 0) {
>> +				pr_err("%s: Could get offset '%s'\n",
>> +					__func__, (char *)rprop->value);
>> +				goto err_fail;
>> +			}
>> +
>> +			/* look into the resolve node for the full path */
>> +			refnode =3D __of_find_node_by_full_name(node, nodestr);
>> +			if (!refnode) {
>> +				pr_warn("%s: Could not find refnode '%s'\n",
>> +					__func__, (char *)rprop->value);
>> +				continue;
>> +			}
>> +
>> +			/* now find the property */
>> +			for_each_property_of_node(refnode, sprop) {
>> +				if (of_prop_cmp(sprop->name, propstr) =3D=3D 0)
>> +					break;
>> +			}
>> +
>> +			if (!sprop) {
>> +				pr_err("%s: Could not find property '%s'\n",
>> +					__func__, (char *)rprop->value);
>> +				err =3D -ENOENT;
>> +				goto err_fail;
>> +			}
>> +
>> +			phandle =3D be32_to_cpup(sprop->value + offset);
>> +			*(__be32 *)(sprop->value + offset) =3D
>> +				cpu_to_be32(phandle + phandle_delta);
>> +		}
>> +
>> +		kfree(propval);
>> +		propval =3D NULL;
>=20
> ... to this line is almost identical to the block in of_resolve(). Ca=
n
> it be moved into a helper function?
>=20

It appears so at first glance.


>> +	}
>> +
>> +	return 0;
>> +
>> +err_fail:
>> +	kfree(propval);
>> +	return err;
>> +}
>> +
>> +/**
>> + * of_resolve	- Resolve the given node against the live tree.
>> + *
>> + * @resolve:	Node to resolve
>> + *
>> + * Perform dynamic Device Tree resolution against the live tree
>> + * to the given node to resolve. This depends on the live tree
>> + * having a __symbols__ node, and the resolve node the __fixups__ &
>> + * __local_fixups__ nodes (if needed).
>> + * The result of the operation is a resolve node that it's contents
>> + * are fit to be inserted or operate upon the live tree.
>> + * Returns 0 on success or a negative error value on error.
>> + */
>> +int of_resolve(struct device_node *resolve)
>> +{
>> +	struct device_node *child, *refnode;
>> +	struct device_node *root_sym, *resolve_sym, *resolve_fix;
>> +	struct property *rprop, *sprop;
>> +	const char *refpath;
>> +	char *propval, *propcur, *propend, *nodestr, *propstr, *s;
>> +	int offset, propcurlen;
>> +	phandle phandle, phandle_delta;
>> +	int err;
>> +
>> +	/* the resolve node must exist, and be detached */
>> +	if (!resolve || !of_node_check_flag(resolve, OF_DETACHED))
>> +		return -EINVAL;
>> +
>> +	/* first we need to adjust the phandles */
>> +	phandle_delta =3D of_get_tree_max_phandle() + 1;
>> +	__of_adjust_tree_phandles(resolve, phandle_delta);
>> +	err =3D __of_adjust_tree_phandle_references(resolve, phandle_delta=
);
>> +	if (err !=3D 0)
>> +		return err;
>> +
>> +	root_sym =3D NULL;
>> +	resolve_sym =3D NULL;
>> +	resolve_fix =3D NULL;
>> +
>> +	/* this may fail (if no fixups are required) */
>> +	root_sym =3D of_find_node_by_path("/__symbols__");
>> +
>> +	/* locate the symbols & fixups nodes on resolve */
>> +	for_each_child_of_node(resolve, child) {
>> +
>> +		if (!resolve_sym &&
>> +				of_node_cmp(child->name, "__symbols__") =3D=3D 0)
>> +			resolve_sym =3D child;
>=20
> Can /aliases be used instead of __symbols__? __symbols__ requires the
> .dtb to be compiled in a particular way and it means an overlay will
> never work with an existing dtb.
>=20

Hmm. Aliases in theory can be used as symbols sure enough.
It is going to be very error prone (since you will need to explicitly d=
efine every symbol,
instead of just relying on the compiler to generate an entry for each l=
abel).

As a change it=92s simple enough...

> We also need to review how overlays match up with nodes in the base
> tree. I can see a board with multiple identical expansion connectors,
> but each connector wires up to different pins. If we made the symbols
> resolution local to the expansion connector, then the same overlay co=
uld
> be used for different ports.
>=20

I have something in mind how to fix this, and some even more wonky case=
s.
Think overlays applied on devices on busses that can be probed like PCI=
/USB etc.

I think we can work the details at ELCE. Perhaps ask the organizers to =
setup the DT
session we discussed.

>> +
>> +		if (!resolve_fix &&
>> +				of_node_cmp(child->name, "__fixups__") =3D=3D 0)
>> +			resolve_fix =3D child;
>> +
>> +		/* both found, don't bother anymore */
>> +		if (resolve_sym && resolve_fix)
>> +			break;
>> +	}
>> +
>> +	/* we do allow for the case where no fixups are needed */
>> +	if (!resolve_fix) {
>> +		err =3D 0;	/* no error */
>> +		goto out;
>> +	}
>> +
>> +	/* we need to fixup, but no root symbols... */
>> +	if (!root_sym) {
>> +		err =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	for_each_property_of_node(resolve_fix, rprop) {
>> +
>> +		/* skip properties added automatically */
>> +		if (of_prop_cmp(rprop->name, "name") =3D=3D 0)
>> +			continue;
>> +
>> +		err =3D of_property_read_string(root_sym,
>> +				rprop->name, &refpath);
>> +		if (err !=3D 0) {
>> +			pr_err("%s: Could not find symbol '%s'\n",
>> +					__func__, rprop->name);
>> +			goto out;
>> +		}
>> +
>> +		refnode =3D of_find_node_by_path(refpath);
>> +		if (!refnode) {
>> +			pr_err("%s: Could not find node by path '%s'\n",
>> +					__func__, refpath);
>> +			err =3D -ENOENT;
>> +			goto out;
>> +		}
>> +
>> +		phandle =3D refnode->phandle;
>> +		of_node_put(refnode);
>> +
>> +		pr_debug("%s: %s phandle is 0x%08x\n",
>> +				__func__, rprop->name, phandle);
>> +
>> +		/* make a copy */
>> +		propval =3D kmalloc(rprop->length, GFP_KERNEL);
>> +		if (!propval) {
>> +			pr_err("%s: Could not copy value of '%s'\n",
>> +					__func__, rprop->name);
>> +			err =3D -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		memcpy(propval, rprop->value, rprop->length);
>> +
>> +		propend =3D propval + rprop->length;
>> +		for (propcur =3D propval; propcur < propend;
>> +				propcur +=3D propcurlen + 1) {
>> +			propcurlen =3D strlen(propcur);
>> +
>> +			nodestr =3D propcur;
>> +			s =3D strchr(propcur, ':');
>> +			if (!s) {
>> +				pr_err("%s: Illegal symbol entry '%s' (1)\n",
>> +					__func__, (char *)rprop->value);
>> +				err =3D -EINVAL;
>> +				goto err_fail_free;
>> +			}
>> +			*s++ =3D '\0';
>> +
>> +			propstr =3D s;
>> +			s =3D strchr(s, ':');
>> +			if (!s) {
>> +				pr_err("%s: Illegal symbol entry '%s' (2)\n",
>> +					__func__, (char *)rprop->value);
>> +				err =3D -EINVAL;
>> +				goto err_fail_free;
>> +			}
>> +
>> +			*s++ =3D '\0';
>> +			err =3D kstrtoint(s, 10, &offset);
>> +			if (err !=3D 0) {
>> +				pr_err("%s: Could get offset '%s'\n",
>> +					__func__, (char *)rprop->value);
>> +				goto err_fail_free;
>> +			}
>> +
>> +			/* look into the resolve node for the full path */
>> +			refnode =3D __of_find_node_by_full_name(resolve,
>> +					nodestr);
>> +			if (!refnode) {
>> +				pr_err("%s: Could not find refnode '%s'\n",
>> +					__func__, (char *)rprop->value);
>> +				err =3D -ENOENT;
>> +				goto err_fail_free;
>> +			}
>> +
>> +			/* now find the property */
>> +			for_each_property_of_node(refnode, sprop) {
>> +				if (of_prop_cmp(sprop->name, propstr) =3D=3D 0)
>> +					break;
>> +			}
>> +
>> +			if (!sprop) {
>> +				pr_err("%s: Could not find property '%s'\n",
>> +					__func__, (char *)rprop->value);
>> +				err =3D -ENOENT;
>> +				goto err_fail_free;
>> +			}
>> +
>> +			*(__be32 *)(sprop->value + offset) =3D
>> +				cpu_to_be32(phandle);
>> +		}
>> +
>> +		kfree(propval);
>> +		propval =3D NULL;
>> +	}
>> +
>> +err_fail_free:
>> +	kfree(propval);
>> +
>> +out:
>> +	/* NULL is handled by of_node_put as NOP */
>> +	of_node_put(root_sym);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(of_resolve);
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index fa81b42..e9be31c 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -903,4 +903,20 @@ static inline int of_transaction_update_propert=
y(struct of_transaction *oft,
>> }
>> #endif
>>=20
>> +/* illegal phandle value (set when unresolved) */
>> +#define OF_PHANDLE_ILLEGAL	0xdeadbeef
>=20
> fdt.c should be made to use this macro also.
>=20

OK.

> I've actually got a patches to makes all these changes. I've been try=
ing
> to get the selftest code to use the resolver. The current code passes
> all the test cases, but while the testcase data is loaded there are
> duplicate phandles in the tree. :-(
>=20

Told you them things are tricky! :)

Remember that patch we talked about a few weeks earlier? About the impl=
icit properties?
"of: dynamic: Handle special properties changes=94. That should do the =
trick.

Speaking of which I think it=92s also time to look over the next set of=
 changes.
Like having a tree DT structure, phandle lists and perhaps copy based d=
evm_* driver APIs.


> g.

Regards

=97 Pantelis

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
