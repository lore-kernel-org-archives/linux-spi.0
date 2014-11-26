From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v8 3/8] OF: DT-Overlay configfs interface (v2)
Date: Wed, 26 Nov 2014 12:49:33 +0000
Message-ID: <20141126124933.ECED6C40914@trevor.secretlab.ca>
References: <1414528565-10907-1-git-send-email-pantelis.antoniou@konsulko.com>
	<1414528565-10907-4-git-send-email-pantelis.antoniou@konsulko.com>
	<20141125102844.79BAEC44089@trevor.secretlab.ca>
	<773D4828-4530-46E7-8786-1DBA490C36EB@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
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
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <773D4828-4530-46E7-8786-1DBA490C36EB-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 25 Nov 2014 16:50:15 +0200
, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
 wrote:
> Hi Grant,
>=20
> > On Nov 25, 2014, at 12:28 , Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org=
> wrote:
> >=20
> > Hi Pantelis,
> >=20
> > Comments below...
> >=20
> > On Tue, 28 Oct 2014 22:36:00 +0200
> > , Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> > wrote:
> >> Add a runtime interface to using configfs for generic device tree =
overlay
> >> usage.
> >>=20
> >> A device-tree configfs entry is created in /config/device-tree/ove=
rlays
> >>=20
> >> * To create an overlay you mkdir the directory:
> >>=20
> >> 	# mkdir /config/device-tree/overlays/foo
> >>=20
> >> * Either you echo the overlay firmware file to the path property f=
ile.
> >>=20
> >> 	# echo foo.dtbo >/config/device-tree/overlays/foo/path
> >>=20
> >> * Or you cat the contents of the overlay to the dtbo file
> >>=20
> >> 	# cat foo.dtbo >/config/device-tree/overlays/foo/dtbo
> >>=20
> >> The overlay file will be applied.
> >>=20
> >> To remove it simply rmdir the directory.
> >>=20
> >> 	# rmdir /config/device-tree/overlays/foo
> >=20
> > The above is documentation on how to use it, but it isn't a good co=
mmit
> > message. The above should be moved into a documentation file (if it
> > isn't already and I've missed it) and the commit message should giv=
e
> > detail about what was needed, what was changed to make it happen, a=
nd
> > what the result of the new code is.
> >=20
>=20
> Hmm, okie dokie.
>=20
> >>=20
> >> Changes since v1:
> >> * of_resolve() -> of_resolve_phandles().
> >>=20
> >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> >> ---
> >> drivers/of/Kconfig    |   7 ++
> >> drivers/of/Makefile   |   1 +
> >> drivers/of/configfs.c | 340 ++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >> 3 files changed, 348 insertions(+)
> >> create mode 100644 drivers/of/configfs.c
> >>=20
> >> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> >> index aa315c4..d59ba40 100644
> >> --- a/drivers/of/Kconfig
> >> +++ b/drivers/of/Kconfig
> >> @@ -90,4 +90,11 @@ config OF_OVERLAY
> >> 	select OF_DEVICE
> >> 	select OF_RESOLVE
> >>=20
> >> +config OF_CONFIGFS
> >> +	bool "OpenFirmware Overlay ConfigFS interface"
> >=20
> > Despite all the APIs being prefixed with OpenFirmware, this isn't a=
n
> > OpenFirmware interface, it is a device tree interface.
> >=20
>=20
> OK, so device tree config fs interface?

Yes

>=20
> >> +	select CONFIGFS_FS
> >> +	select OF_OVERLAY
> >> +	help
> >> +	  Enable a simple user-space driver DT overlay interface.
> >> +
> >> endmenu # OF
> >> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> >> index 1bfe462..6d12949 100644
> >> --- a/drivers/of/Makefile
> >> +++ b/drivers/of/Makefile
> >> @@ -15,6 +15,7 @@ obj-$(CONFIG_OF_MTD)	+=3D of_mtd.o
> >> obj-$(CONFIG_OF_RESERVED_MEM) +=3D of_reserved_mem.o
> >> obj-$(CONFIG_OF_RESOLVE)  +=3D resolver.o
> >> obj-$(CONFIG_OF_OVERLAY) +=3D overlay.o
> >> +obj-$(CONFIG_OF_CONFIGFS) +=3D configfs.o
> >=20
> > Tip: Insert lines in the middle of the block, roughly alphabeticall=
y
> > sorted. It cuts down on merge conflicts that way.
> >=20
>=20
> k
>=20
> >>=20
> >> CFLAGS_fdt.o =3D -I$(src)/../../scripts/dtc/libfdt
> >> CFLAGS_fdt_address.o =3D -I$(src)/../../scripts/dtc/libfdt
> >> diff --git a/drivers/of/configfs.c b/drivers/of/configfs.c
> >> new file mode 100644
> >> index 0000000..932f572
> >> --- /dev/null
> >> +++ b/drivers/of/configfs.c
> >> @@ -0,0 +1,340 @@
> >> +/*
> >> + * Configfs entries for device-tree
> >> + *
> >> + * Copyright (C) 2013 - Pantelis Antoniou <panto@antoniou-consult=
ing.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License
> >> + * as published by the Free Software Foundation; either version
> >> + * 2 of the License, or (at your option) any later version.
> >> + */
> >> +#include <linux/ctype.h>
> >> +#include <linux/cpu.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_fdt.h>
> >> +#include <linux/spinlock.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/proc_fs.h>
> >> +#include <linux/configfs.h>
> >> +#include <linux/types.h>
> >> +#include <linux/stat.h>
> >> +#include <linux/limits.h>
> >> +#include <linux/file.h>
> >> +#include <linux/vmalloc.h>
> >> +#include <linux/firmware.h>
> >> +
> >> +#include "of_private.h"
> >> +
> >> +#ifdef CONFIG_OF_OVERLAY
> >=20
> > ???
> >=20
> > This file shouldn't even be compiled if CONFIG_OF_OVERLAY isn't
> > selected. Why is this here?
> >=20
>=20
> Err, good question.
>=20
> >> +
> >> +struct cfs_overlay_item {
> >> +	struct config_item	item;
> >> +
> >> +	char			path[PATH_MAX];
> >> +
> >> +	const struct firmware	*fw;
> >> +	struct device_node	*overlay;
> >> +	int			ov_id;
> >> +
> >> +	void			*dtbo;
> >> +	int			dtbo_size;
> >> +};
> >> +
> >> +static int create_overlay(struct cfs_overlay_item *overlay, void =
*blob)
> >> +{
> >> +	int err;
> >> +
> >> +	/* unflatten the tree */
> >> +	of_fdt_unflatten_tree((void *)blob, &overlay->overlay);
> >=20
> > blob is already void*
> >=20
>=20
> ok
>=20
> >> +	if (overlay->overlay =3D=3D NULL) {
> >> +		pr_err("%s: failed to unflatten tree\n", __func__);
> >> +		err =3D -EINVAL;
> >> +		goto out_err;
> >> +	}
> >> +	pr_debug("%s: unflattened OK\n", __func__);
> >> +
> >> +	/* mark it as detached */
> >> +	of_node_set_flag(overlay->overlay, OF_DETACHED);
> >> +
> >> +	/* perform resolution */
> >> +	err =3D of_resolve_phandles(overlay->overlay);
> >> +	if (err !=3D 0) {
> >> +		pr_err("%s: Failed to resolve tree\n", __func__);
> >> +		goto out_err;
> >> +	}
> >> +	pr_debug("%s: resolved OK\n", __func__);
> >> +
> >> +	err =3D of_overlay_create(overlay->overlay);
> >> +	if (err < 0) {
> >> +		pr_err("%s: Failed to create overlay (err=3D%d)\n",
> >> +				__func__, err);
> >> +		goto out_err;
> >> +	}
> >> +	overlay->ov_id =3D err;
> >> +
> >> +out_err:
> >> +	return err;
> >> +}
> >> +
> >> +static inline struct cfs_overlay_item *to_cfs_overlay_item(
> >> +		struct config_item *item)
> >> +{
> >> +	return item ? container_of(item, struct cfs_overlay_item, item) =
: NULL;
> >> +}
> >> +
> >> +CONFIGFS_ATTR_STRUCT(cfs_overlay_item);
> >> +#define CFS_OVERLAY_ITEM_ATTR(_name, _mode, _show, _store)	\
> >> +struct cfs_overlay_item_attribute cfs_overlay_item_attr_##_name =3D=
 \
> >> +	__CONFIGFS_ATTR(_name, _mode, _show, _store)
> >> +#define CFS_OVERLAY_ITEM_ATTR_RO(_name, _show)	\
> >> +struct cfs_overlay_item_attribute cfs_overlay_item_attr_##_name =3D=
 \
> >> +	__CONFIGFS_ATTR_RO(_name, _show)
> >> +
> >> +CONFIGFS_BIN_ATTR_STRUCT(cfs_overlay_item);
> >> +#define CFS_OVERLAY_ITEM_BIN_ATTR(_name, _mode, _read, _write, _p=
riv, _max) \
> >> +struct cfs_overlay_item_bin_attribute cfs_overlay_item_bin_attr_#=
#_name =3D \
> >> +	__CONFIGFS_BIN_ATTR(_name, _mode, _read, _write, _priv, _max)
> >> +#define CFS_OVERLAY_ITEM_BIN_ATTR_RO(_name, _read, _priv, _max)	\
> >> +struct cfs_overlay_item_bin_attribute cfs_overlay_item_bin_attr_#=
#_name =3D \
> >> +	__CONFIGFS_BIN_ATTR_RO(_name, _read, _priv, _max)
> >> +
> >> +static ssize_t cfs_overlay_item_path_show(struct cfs_overlay_item=
 *overlay,
> >> +		char *page)
> >> +{
> >> +	return sprintf(page, "%s\n", overlay->path);
> >> +}
> >> +
> >> +static ssize_t cfs_overlay_item_path_store(struct cfs_overlay_ite=
m *overlay,
> >> +		const char *page, size_t count)
> >> +{
> >> +	const char *p =3D page;
> >> +	char *s;
> >> +	int err;
> >> +
> >> +	/* if it's set do not allow changes */
> >> +	if (overlay->path[0] !=3D '\0' || overlay->dtbo_size > 0)
> >> +		return -EPERM;
> >> +
> >> +	/* copy to path buffer (and make sure it's always zero terminate=
d */
> >> +	count =3D snprintf(overlay->path, sizeof(overlay->path) - 1, "%s=
", p);
> >> +	overlay->path[sizeof(overlay->path) - 1] =3D '\0';
> >> +
> >> +	/* strip trailing newlines */
> >> +	s =3D overlay->path + strlen(overlay->path);
> >> +	while (s > overlay->path && *--s =3D=3D '\n')
> >> +		*s =3D '\0';
> >> +
> >> +	pr_debug("%s: path is '%s'\n", __func__, overlay->path);
> >> +
> >> +	err =3D request_firmware(&overlay->fw, overlay->path, NULL);
> >> +	if (err !=3D 0)
> >> +		goto out_err;
> >> +
> >> +	err =3D create_overlay(overlay, (void *)overlay->fw->data);
> >> +	if (err !=3D 0)
> >> +		goto out_err;
> >> +
> >> +	return count;
> >> +
> >> +out_err:
> >> +
> >> +	release_firmware(overlay->fw);
> >> +	overlay->fw =3D NULL;
> >> +
> >> +	overlay->path[0] =3D '\0';
> >> +	return err;
> >> +}
> >> +
> >> +static ssize_t cfs_overlay_item_status_show(struct cfs_overlay_it=
em *overlay,
> >> +		char *page)
> >> +{
> >> +	return sprintf(page, "%s\n",
> >> +			overlay->ov_id >=3D 0 ? "applied" : "unapplied");
> >> +}
> >> +
> >> +CFS_OVERLAY_ITEM_ATTR(path, S_IRUGO | S_IWUSR,
> >> +		cfs_overlay_item_path_show, cfs_overlay_item_path_store);
> >=20
> > World writable? Am I reading this correctly?
> >=20
>=20
> Err, user writeable, world readable. =E2=80=9C-rw-r--r=E2=80=94"

Oops, I did read it wrong. Sorry for the noise

> > DT modifications are privileged. A user can potentially get arbitra=
ry
> > access to i2c, spi, gpio or other things that shouldn't be allowed.=
 This
> > feature give access right into the Linux driver model.
> >=20
>=20
> Yes, it does.
>=20
> > Before this can be merged, it needs to be locked down, and there ne=
eds
> > to be documentation about how it is locked down. Owned by root is o=
nly
> > the first step, there also needs to be some rules about which nodes=
 can
> > be modified by the configfs interface. By default think no modifica=
tions
> > should be allowed on a tree unless there are properties somewhere i=
n the
> > tree that explicitly allow modifications to be performed.
> >=20
>=20
> TBH this is more of a debug level interface. The way I see it a diffe=
rent
> overlay manager, that=E2=80=99s tuned to the platform, should handle =
the overlay
> request and application, in a manner that=E2=80=99s not directly open=
 to user
> control. For example in a beaglebone you=E2=80=99d have a =E2=80=98ca=
pe=E2=80=99 manager reading
> the i2c eeproms and request the overlays they match without any user-=
space
> implication.

Right.

> However, this is an interface that developers will use daily, so I ag=
ree
> that we need to look into the security model now before it=E2=80=99s =
too late.
>=20
> How do you feel for something like this in chosen:
>=20
> overlay-targets =3D =E2=80=9C/ocp=E2=80=9D, =E2=80=9C/pinctrl=E2=80=9D=
;

It's a reasonable proposal. I'd like to have some time to think on it
though. The other way to do it would be to add properties throughout th=
e
tree that mask/unmask modifications by overlay. I think the overlays ar=
e
more a property of the board than a configurable boot time argument (so
not something that would normally go in /chosen)

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
