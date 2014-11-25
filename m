From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH v8 3/8] OF: DT-Overlay configfs interface (v2)
Date: Tue, 25 Nov 2014 16:50:15 +0200
Message-ID: <773D4828-4530-46E7-8786-1DBA490C36EB@antoniou-consulting.com>
References: <1414528565-10907-1-git-send-email-pantelis.antoniou@konsulko.com> <1414528565-10907-4-git-send-email-pantelis.antoniou@konsulko.com> <20141125102844.79BAEC44089@trevor.secretlab.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rob Herring <robherring2@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Matt Porter <matt.porter@linaro.org>,
	Koen Kooi <koen@dominion.thruhere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Chaiken <Alison_Chaiken@mentor.com>,
	Dinh Nguyen <dinh.linux@gmail.com>,
	Jan Lubbe <jluebbe@lasnet.de>,
	Alexander Sverdlin <alexander.sverdlin@nsn.com>,
	Michael Stickel <ms@mycable.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Dirk Behme <dirk.behme@gmail.com>,
	Alan Tull <delicious.quinoa@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Michael Bohan <mbohan@codeaurora.org>,
	Ionut Nicu <ioan.nicu.ext@nsn.com>,
	Michal Simek <monstr@monstr.eu>,
	Matt Ranostay <mranostay@gmail.com>,
	Joel Becker <jlbec@evilplan.org>, devicetree@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141125102844.79BAEC44089@trevor.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

> On Nov 25, 2014, at 12:28 , Grant Likely <grant.likely@secretlab.ca> =
wrote:
>=20
> Hi Pantelis,
>=20
> Comments below...
>=20
> On Tue, 28 Oct 2014 22:36:00 +0200
> , Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> wrote:
>> Add a runtime interface to using configfs for generic device tree ov=
erlay
>> usage.
>>=20
>> A device-tree configfs entry is created in /config/device-tree/overl=
ays
>>=20
>> * To create an overlay you mkdir the directory:
>>=20
>> 	# mkdir /config/device-tree/overlays/foo
>>=20
>> * Either you echo the overlay firmware file to the path property fil=
e.
>>=20
>> 	# echo foo.dtbo >/config/device-tree/overlays/foo/path
>>=20
>> * Or you cat the contents of the overlay to the dtbo file
>>=20
>> 	# cat foo.dtbo >/config/device-tree/overlays/foo/dtbo
>>=20
>> The overlay file will be applied.
>>=20
>> To remove it simply rmdir the directory.
>>=20
>> 	# rmdir /config/device-tree/overlays/foo
>=20
> The above is documentation on how to use it, but it isn't a good comm=
it
> message. The above should be moved into a documentation file (if it
> isn't already and I've missed it) and the commit message should give
> detail about what was needed, what was changed to make it happen, and
> what the result of the new code is.
>=20

Hmm, okie dokie.

>>=20
>> Changes since v1:
>> * of_resolve() -> of_resolve_phandles().
>>=20
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>> ---
>> drivers/of/Kconfig    |   7 ++
>> drivers/of/Makefile   |   1 +
>> drivers/of/configfs.c | 340 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>> 3 files changed, 348 insertions(+)
>> create mode 100644 drivers/of/configfs.c
>>=20
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index aa315c4..d59ba40 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -90,4 +90,11 @@ config OF_OVERLAY
>> 	select OF_DEVICE
>> 	select OF_RESOLVE
>>=20
>> +config OF_CONFIGFS
>> +	bool "OpenFirmware Overlay ConfigFS interface"
>=20
> Despite all the APIs being prefixed with OpenFirmware, this isn't an
> OpenFirmware interface, it is a device tree interface.
>=20

OK, so device tree config fs interface?

>> +	select CONFIGFS_FS
>> +	select OF_OVERLAY
>> +	help
>> +	  Enable a simple user-space driver DT overlay interface.
>> +
>> endmenu # OF
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index 1bfe462..6d12949 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_OF_MTD)	+=3D of_mtd.o
>> obj-$(CONFIG_OF_RESERVED_MEM) +=3D of_reserved_mem.o
>> obj-$(CONFIG_OF_RESOLVE)  +=3D resolver.o
>> obj-$(CONFIG_OF_OVERLAY) +=3D overlay.o
>> +obj-$(CONFIG_OF_CONFIGFS) +=3D configfs.o
>=20
> Tip: Insert lines in the middle of the block, roughly alphabetically
> sorted. It cuts down on merge conflicts that way.
>=20

k

>>=20
>> CFLAGS_fdt.o =3D -I$(src)/../../scripts/dtc/libfdt
>> CFLAGS_fdt_address.o =3D -I$(src)/../../scripts/dtc/libfdt
>> diff --git a/drivers/of/configfs.c b/drivers/of/configfs.c
>> new file mode 100644
>> index 0000000..932f572
>> --- /dev/null
>> +++ b/drivers/of/configfs.c
>> @@ -0,0 +1,340 @@
>> +/*
>> + * Configfs entries for device-tree
>> + *
>> + * Copyright (C) 2013 - Pantelis Antoniou <panto@antoniou-consultin=
g.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +#include <linux/ctype.h>
>> +#include <linux/cpu.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/slab.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/configfs.h>
>> +#include <linux/types.h>
>> +#include <linux/stat.h>
>> +#include <linux/limits.h>
>> +#include <linux/file.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/firmware.h>
>> +
>> +#include "of_private.h"
>> +
>> +#ifdef CONFIG_OF_OVERLAY
>=20
> ???
>=20
> This file shouldn't even be compiled if CONFIG_OF_OVERLAY isn't
> selected. Why is this here?
>=20

Err, good question.

>> +
>> +struct cfs_overlay_item {
>> +	struct config_item	item;
>> +
>> +	char			path[PATH_MAX];
>> +
>> +	const struct firmware	*fw;
>> +	struct device_node	*overlay;
>> +	int			ov_id;
>> +
>> +	void			*dtbo;
>> +	int			dtbo_size;
>> +};
>> +
>> +static int create_overlay(struct cfs_overlay_item *overlay, void *b=
lob)
>> +{
>> +	int err;
>> +
>> +	/* unflatten the tree */
>> +	of_fdt_unflatten_tree((void *)blob, &overlay->overlay);
>=20
> blob is already void*
>=20

ok

>> +	if (overlay->overlay =3D=3D NULL) {
>> +		pr_err("%s: failed to unflatten tree\n", __func__);
>> +		err =3D -EINVAL;
>> +		goto out_err;
>> +	}
>> +	pr_debug("%s: unflattened OK\n", __func__);
>> +
>> +	/* mark it as detached */
>> +	of_node_set_flag(overlay->overlay, OF_DETACHED);
>> +
>> +	/* perform resolution */
>> +	err =3D of_resolve_phandles(overlay->overlay);
>> +	if (err !=3D 0) {
>> +		pr_err("%s: Failed to resolve tree\n", __func__);
>> +		goto out_err;
>> +	}
>> +	pr_debug("%s: resolved OK\n", __func__);
>> +
>> +	err =3D of_overlay_create(overlay->overlay);
>> +	if (err < 0) {
>> +		pr_err("%s: Failed to create overlay (err=3D%d)\n",
>> +				__func__, err);
>> +		goto out_err;
>> +	}
>> +	overlay->ov_id =3D err;
>> +
>> +out_err:
>> +	return err;
>> +}
>> +
>> +static inline struct cfs_overlay_item *to_cfs_overlay_item(
>> +		struct config_item *item)
>> +{
>> +	return item ? container_of(item, struct cfs_overlay_item, item) : =
NULL;
>> +}
>> +
>> +CONFIGFS_ATTR_STRUCT(cfs_overlay_item);
>> +#define CFS_OVERLAY_ITEM_ATTR(_name, _mode, _show, _store)	\
>> +struct cfs_overlay_item_attribute cfs_overlay_item_attr_##_name =3D=
 \
>> +	__CONFIGFS_ATTR(_name, _mode, _show, _store)
>> +#define CFS_OVERLAY_ITEM_ATTR_RO(_name, _show)	\
>> +struct cfs_overlay_item_attribute cfs_overlay_item_attr_##_name =3D=
 \
>> +	__CONFIGFS_ATTR_RO(_name, _show)
>> +
>> +CONFIGFS_BIN_ATTR_STRUCT(cfs_overlay_item);
>> +#define CFS_OVERLAY_ITEM_BIN_ATTR(_name, _mode, _read, _write, _pri=
v, _max) \
>> +struct cfs_overlay_item_bin_attribute cfs_overlay_item_bin_attr_##_=
name =3D \
>> +	__CONFIGFS_BIN_ATTR(_name, _mode, _read, _write, _priv, _max)
>> +#define CFS_OVERLAY_ITEM_BIN_ATTR_RO(_name, _read, _priv, _max)	\
>> +struct cfs_overlay_item_bin_attribute cfs_overlay_item_bin_attr_##_=
name =3D \
>> +	__CONFIGFS_BIN_ATTR_RO(_name, _read, _priv, _max)
>> +
>> +static ssize_t cfs_overlay_item_path_show(struct cfs_overlay_item *=
overlay,
>> +		char *page)
>> +{
>> +	return sprintf(page, "%s\n", overlay->path);
>> +}
>> +
>> +static ssize_t cfs_overlay_item_path_store(struct cfs_overlay_item =
*overlay,
>> +		const char *page, size_t count)
>> +{
>> +	const char *p =3D page;
>> +	char *s;
>> +	int err;
>> +
>> +	/* if it's set do not allow changes */
>> +	if (overlay->path[0] !=3D '\0' || overlay->dtbo_size > 0)
>> +		return -EPERM;
>> +
>> +	/* copy to path buffer (and make sure it's always zero terminated =
*/
>> +	count =3D snprintf(overlay->path, sizeof(overlay->path) - 1, "%s",=
 p);
>> +	overlay->path[sizeof(overlay->path) - 1] =3D '\0';
>> +
>> +	/* strip trailing newlines */
>> +	s =3D overlay->path + strlen(overlay->path);
>> +	while (s > overlay->path && *--s =3D=3D '\n')
>> +		*s =3D '\0';
>> +
>> +	pr_debug("%s: path is '%s'\n", __func__, overlay->path);
>> +
>> +	err =3D request_firmware(&overlay->fw, overlay->path, NULL);
>> +	if (err !=3D 0)
>> +		goto out_err;
>> +
>> +	err =3D create_overlay(overlay, (void *)overlay->fw->data);
>> +	if (err !=3D 0)
>> +		goto out_err;
>> +
>> +	return count;
>> +
>> +out_err:
>> +
>> +	release_firmware(overlay->fw);
>> +	overlay->fw =3D NULL;
>> +
>> +	overlay->path[0] =3D '\0';
>> +	return err;
>> +}
>> +
>> +static ssize_t cfs_overlay_item_status_show(struct cfs_overlay_item=
 *overlay,
>> +		char *page)
>> +{
>> +	return sprintf(page, "%s\n",
>> +			overlay->ov_id >=3D 0 ? "applied" : "unapplied");
>> +}
>> +
>> +CFS_OVERLAY_ITEM_ATTR(path, S_IRUGO | S_IWUSR,
>> +		cfs_overlay_item_path_show, cfs_overlay_item_path_store);
>=20
> World writable? Am I reading this correctly?
>=20

Err, user writeable, world readable. =E2=80=9C-rw-r--r=E2=80=94"

> DT modifications are privileged. A user can potentially get arbitrary
> access to i2c, spi, gpio or other things that shouldn't be allowed. T=
his
> feature give access right into the Linux driver model.
>=20

Yes, it does.

> Before this can be merged, it needs to be locked down, and there need=
s
> to be documentation about how it is locked down. Owned by root is onl=
y
> the first step, there also needs to be some rules about which nodes c=
an
> be modified by the configfs interface. By default think no modificati=
ons
> should be allowed on a tree unless there are properties somewhere in =
the
> tree that explicitly allow modifications to be performed.
>=20

TBH this is more of a debug level interface. The way I see it a differe=
nt
overlay manager, that=E2=80=99s tuned to the platform, should handle th=
e overlay
request and application, in a manner that=E2=80=99s not directly open t=
o user
control. For example in a beaglebone you=E2=80=99d have a =E2=80=98cape=
=E2=80=99 manager reading
the i2c eeproms and request the overlays they match without any user-sp=
ace
implication.

However, this is an interface that developers will use daily, so I agre=
e
that we need to look into the security model now before it=E2=80=99s to=
o late.

How do you feel for something like this in chosen:

overlay-targets =3D =E2=80=9C/ocp=E2=80=9D, =E2=80=9C/pinctrl=E2=80=9D;

That would allow overlays to target the ocp and pinctrl nodes (and all =
their
children). To allow overlays to attach everywhere just use

overlay-targets =3D =E2=80=9C/=E2=80=9C;

> Regardless, there needs to be a proposal made about the security mode=
l
> so that it can be discussed and analyzed by folks better versed in
> security that either of us. I would like to get Kees Cook to take a l=
ook
> at what we are doing here.
>=20

Admittedly we could use some help here.
=20
>> +CFS_OVERLAY_ITEM_ATTR_RO(status, cfs_overlay_item_status_show);
>> +
>> +static struct configfs_attribute *cfs_overlay_attrs[] =3D {
>> +	&cfs_overlay_item_attr_path.attr,
>> +	&cfs_overlay_item_attr_status.attr,
>> +	NULL,
>> +};
>> +
>> +ssize_t cfs_overlay_item_dtbo_read(struct cfs_overlay_item *overlay=
,
>> +		void *buf, size_t max_count)
>> +{
>> +	pr_debug("%s: buf=3D%p max_count=3D%u\n", __func__,
>> +			buf, max_count);
>> +
>> +	if (overlay->dtbo =3D=3D NULL)
>> +		return 0;
>> +
>> +	/* copy if buffer provided */
>> +	if (buf !=3D NULL) {
>> +		/* the buffer must be large enough */
>> +		if (overlay->dtbo_size > max_count)
>> +			return -ENOSPC;
>> +
>> +		memcpy(buf, overlay->dtbo, overlay->dtbo_size);
>> +	}
>> +
>> +	return overlay->dtbo_size;
>> +}
>> +
>> +ssize_t cfs_overlay_item_dtbo_write(struct cfs_overlay_item *overla=
y,
>> +		const void *buf, size_t count)
>> +{
>> +	int err;
>> +
>> +	/* if it's set do not allow changes */
>> +	if (overlay->path[0] !=3D '\0' || overlay->dtbo_size > 0)
>> +		return -EPERM;
>> +
>> +	/* copy the contents */
>> +	overlay->dtbo =3D kmemdup(buf, count, GFP_KERNEL);
>> +	if (overlay->dtbo =3D=3D NULL)
>> +		return -ENOMEM;
>> +
>> +	overlay->dtbo_size =3D count;
>> +
>> +	err =3D create_overlay(overlay, overlay->dtbo);
>> +	if (err !=3D 0)
>> +		goto out_err;
>> +
>> +	return count;
>> +
>> +out_err:
>> +	kfree(overlay->dtbo);
>> +	overlay->dtbo =3D NULL;
>> +	overlay->dtbo_size =3D 0;
>> +
>> +	return err;
>> +}
>> +
>> +CFS_OVERLAY_ITEM_BIN_ATTR(dtbo, S_IRUGO | S_IWUSR,
>> +		cfs_overlay_item_dtbo_read, cfs_overlay_item_dtbo_write,
>> +		NULL, SZ_1M);
>> +
>> +static struct configfs_bin_attribute *cfs_overlay_bin_attrs[] =3D {
>> +	&cfs_overlay_item_bin_attr_dtbo.bin_attr,
>> +	NULL,
>> +};
>> +
>> +static void cfs_overlay_release(struct config_item *item)
>> +{
>> +	struct cfs_overlay_item *overlay =3D to_cfs_overlay_item(item);
>> +
>> +	if (overlay->ov_id >=3D 0)
>> +		of_overlay_destroy(overlay->ov_id);
>> +	if (overlay->fw)
>> +		release_firmware(overlay->fw);
>> +	/* kfree with NULL is safe */
>> +	kfree(overlay->dtbo);
>> +	kfree(overlay);
>> +}
>> +
>> +CONFIGFS_ATTR_OPS(cfs_overlay_item);
>> +CONFIGFS_BIN_ATTR_OPS(cfs_overlay_item);
>> +static struct configfs_item_operations cfs_overlay_item_ops =3D {
>> +	.release		=3D cfs_overlay_release,
>> +	.show_attribute		=3D cfs_overlay_item_attr_show,
>> +	.store_attribute	=3D cfs_overlay_item_attr_store,
>> +	.read_bin_attribute	=3D cfs_overlay_item_bin_attr_read,
>> +	.write_bin_attribute	=3D cfs_overlay_item_bin_attr_write,
>> +};
>> +
>> +static struct config_item_type cfs_overlay_type =3D {
>> +	.ct_item_ops	=3D &cfs_overlay_item_ops,
>> +	.ct_attrs	=3D cfs_overlay_attrs,
>> +	.ct_bin_attrs	=3D cfs_overlay_bin_attrs,
>> +	.ct_owner	=3D THIS_MODULE,
>> +};
>> +
>> +static struct config_item *cfs_overlay_group_make_item(
>> +		struct config_group *group, const char *name)
>> +{
>> +	struct cfs_overlay_item *overlay;
>> +
>> +	overlay =3D kzalloc(sizeof(*overlay), GFP_KERNEL);
>> +	if (!overlay)
>> +		return ERR_PTR(-ENOMEM);
>> +	overlay->ov_id =3D -1;
>> +
>> +	config_item_init_type_name(&overlay->item, name, &cfs_overlay_type=
);
>> +	return &overlay->item;
>> +}
>> +
>> +static void cfs_overlay_group_drop_item(struct config_group *group,
>> +		struct config_item *item)
>> +{
>> +	struct cfs_overlay_item *overlay =3D to_cfs_overlay_item(item);
>> +
>> +	config_item_put(&overlay->item);
>> +}
>> +
>> +static struct configfs_group_operations overlays_ops =3D {
>> +	.make_item	=3D cfs_overlay_group_make_item,
>> +	.drop_item	=3D cfs_overlay_group_drop_item,
>> +};
>> +
>> +static struct config_item_type overlays_type =3D {
>> +	.ct_group_ops   =3D &overlays_ops,
>> +	.ct_owner       =3D THIS_MODULE,
>> +};
>> +
>> +#endif /* CONFIG_OF_OVERLAY */
>> +
>> +static struct configfs_group_operations of_cfs_ops =3D {
>> +	/* empty - we don't allow anything to be created */
>> +};
>> +
>> +static struct config_item_type of_cfs_type =3D {
>> +	.ct_group_ops   =3D &of_cfs_ops,
>> +	.ct_owner       =3D THIS_MODULE,
>> +};
>> +
>> +struct config_group of_cfs_overlay_group;
>> +
>> +struct config_group *of_cfs_def_groups[] =3D {
>> +#ifdef CONFIG_OF_OVERLAY
>> +	&of_cfs_overlay_group,
>> +#endif
>> +	NULL
>> +};
>> +
>> +static struct configfs_subsystem of_cfs_subsys =3D {
>> +	.su_group =3D {
>> +		.cg_item =3D {
>> +			.ci_namebuf =3D "device-tree",
>> +			.ci_type =3D &of_cfs_type,
>> +		},
>> +		.default_groups =3D of_cfs_def_groups,
>> +	},
>> +	.su_mutex =3D __MUTEX_INITIALIZER(of_cfs_subsys.su_mutex),
>> +};
>> +
>> +static int __init of_cfs_init(void)
>> +{
>> +	int ret;
>> +
>> +	pr_info("%s\n", __func__);
>> +
>> +	config_group_init(&of_cfs_subsys.su_group);
>> +#ifdef CONFIG_OF_OVERLAY
>> +	config_group_init_type_name(&of_cfs_overlay_group, "overlays",
>> +			&overlays_type);
>> +#endif
>> +
>> +	ret =3D configfs_register_subsystem(&of_cfs_subsys);
>> +	if (ret !=3D 0) {
>> +		pr_err("%s: failed to register subsys\n", __func__);
>> +		goto out;
>> +	}
>> +	pr_info("%s: OK\n", __func__);
>> +out:
>> +	return ret;
>> +}
>> +late_initcall(of_cfs_init);
>> --=20
>> 1.7.12
>>=20

Regards

=E2=80=94 Pantelis
