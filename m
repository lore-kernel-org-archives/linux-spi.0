Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCF3C73C0
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334418; cv=none; b=iLxOQKFkxlT/gOTVYXf3xC3WdZmFYwNQqtDhHdDA5XNpUsMi3ntK33B6thJJJZTpyKgqZSjGLRNZrwq64GnHcQ+DqbYDz2ZZ2bMqzkOI9oEsEVHL2c5C22PcFkeIGX5yDUNB1uiF10YD4Po1ddSemtdjLOh1/qZIqLJCnj2Bjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334418; c=relaxed/simple;
	bh=rY2qv0nwiQXwqu4138tpVek9SPsqYr/bD9nk0GjmQaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7/E+7wO8Ri6RMoHfVtZ3hk8j8B51Pwmjl532mPlKDkbzb7ZfEHLfFPadJqwky7tJy9GzH9A+0YASoSbGj2mIgKSYXmMuYrkWaki/x3O6kVAZo99/DAnqFoGbyZSnLBkZL9GV6FVtNfwD934Ji7qyUyPXhofJFXXgGlkmsufEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OI3mybbD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OI3mybbD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b05761bec1so27008765ad.1
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334408; x=1774939208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/HQ1k4gbALz2JM52q8iV6sF5/svhBt6Kuq82Depajo=;
        b=OI3mybbDOw/EhHu/ZcVdP0nK23LGhn0aa/X4JV+44z1dORHFhvTO575IUghMOLikh2
         cXcomvH1KPyhLNjDjxgD3beHXmGPvY6UcNxqQmi/V4G/lt5YBPC6UNUJHrab7aZaFCXN
         9qOIH2p6mdKHlRD5pM+u2M8YUCIOlM+UmmuX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334408; x=1774939208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/HQ1k4gbALz2JM52q8iV6sF5/svhBt6Kuq82Depajo=;
        b=h7A7Q3dUDUWg7akNGFQuVYNjj0EsNVMU8o6WiGtfHNJSwzOIPF6uLMda0TDG6cRC9n
         SGd5BPzYbFv/gj8E9j9e00HJhxkoku6WeY+7zyfb0xFYKnAVB1n89dmnhXBiO3lW2fy6
         VrlNa6c55tUP8L58jBQN0rsWCI5KwKQkSQj8//1mverCeILN9fx1W/1JI+3hJvT8awuA
         IAW1nqWhlnw8WEU5EJKsvEm4iyKHe2Jke8tc7C/BQKOWqwfqav7L4pQc8qQ585VM2WDY
         7W7Lw4AJsPog3+1HuzLBZRj68DI6t/d4RRBvToLqle3+tb6XlMElGn/jd3lEVsbGqPro
         Akzw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6Nrj5kgcZVyOISShFMSPGMmG/oWtExfXelus/OhR1K3PoFaYV5Wdd4QGn1Kcmbshea1SbJiuYRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxizeMRecaC+eJU+aSUU0QGEPwlHgAfqTGvSYIxFRAO6km+cjhM
	T38L6ZKkYPF8k00h258wDccH6D8wSY6mUW8VeAaI9/NvP8nsMI8jhmIdVB8qtIgGag==
X-Gm-Gg: ATEYQzzAUDnVc9ByrV4qnhGsJHXrscQ+9CaXWGPRtXe4rICFHYsgfZ614srE1ST/hPx
	44L0orLa/2PjyWoKSd1kA51z8JPE0qiLeYkvJ001R0ZIwzzgK3DFZfUHjEbooMPSzoXgh2PwbKl
	3YAt6USUdG8cOT4pCXaAavQKGYKhqy06WAk1x5JK/EyiZ+5idmLKbWmhVteDvjls48Ml8AUg97L
	XSMhqEWhFeQSleXAeMa70Je1+GclfR3Uj6/HIKG6DlvgTuoTuBY7h+5ZjOmIjJGLeg4CmCdyj3D
	2PO1nze+b20JXe0szpkNYhx2NhlVaB0jJHbi5MCzxQ59my3aVRA3OEDj0Ma6qCbkRacGrfMDStC
	x2EcO8igTRkI2jJ1s936lAEO5zo8cGJ1eAAGyYwSAOSaIG7QXjVdKIY52ZDfEIlqjwV0TzG95fj
	qok66U0k+3acgwTVN0lwR5OA+jVxKzQ5XU4TqwKzXCwrVY3Nn2yg0BCe0dzaYtKlzW7lK56gcju
	hSwXWQFFYvTCGNyDbr89Mq8WJvNsxXkmw==
X-Received: by 2002:a17:902:f552:b0:2b0:62cf:3537 with SMTP id d9443c01a7336-2b0a4db2991mr19875505ad.6.1774334407596;
        Mon, 23 Mar 2026 23:40:07 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:07 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:39 +0000
Subject: [PATCH v2 06/11] HID: spi_hid: add spi_hid traces
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-6-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=11791;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=rY2qv0nwiQXwqu4138tpVek9SPsqYr/bD9nk0GjmQaI=;
 b=BkH3K4lWcvMw6A1eN8KuZE+c3hleZnv7JFhMYxRqPr9xPssXpr5lDxrekSft1IDnKhFLP4APO
 5Rw+mI33JoHCqoLjQsNcxc6WfOgFLZtfa68O315MQq9KAKj1JM5gOM9
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add traces for purposed of debugging spi_hid driver.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c |  74 ------------------
 drivers/hid/spi-hid/spi-hid-core.h |  86 ++++++++++++++++++++
 include/trace/events/spi_hid.h     | 156 +++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 74 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 79bec3303968..3105884b656e 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -81,13 +81,6 @@
 #define SPI_HID_CREATE_DEVICE	4
 #define SPI_HID_ERROR	5
 
-/* Raw input buffer with data from the bus */
-struct spi_hid_input_buf {
-	u8 header[HIDSPI_INPUT_HEADER_SIZE];
-	u8 body[HIDSPI_INPUT_BODY_HEADER_SIZE];
-	u8 content[];
-};
-
 /* Processed data from input report header */
 struct spi_hid_input_header {
 	u8 version;
@@ -104,12 +97,6 @@ struct spi_hid_input_report {
 	u8 *content;
 };
 
-/* Raw output report buffer to be put on the bus */
-struct spi_hid_output_buf {
-	u8 header[SPI_HID_OUTPUT_HEADER_LEN];
-	u8 content[];
-};
-
 /* Data necessary to send an output report */
 struct spi_hid_output_report {
 	u8 report_type;
@@ -118,19 +105,6 @@ struct spi_hid_output_report {
 	u8 *content;
 };
 
-/* Processed data from a device descriptor */
-struct spi_hid_device_descriptor {
-	u16 hid_version;
-	u16 report_descriptor_length;
-	u16 max_input_length;
-	u16 max_output_length;
-	u16 max_fragment_length;
-	u16 vendor_id;
-	u16 product_id;
-	u16 version_id;
-	u8 no_output_report_ack;
-};
-
 /* struct spi_hid_conf - Conf provided to the core */
 struct spi_hid_conf {
 	u32 input_report_header_address;
@@ -156,54 +130,6 @@ struct spihid_ops {
 	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
 };
 
-/* Driver context */
-struct spi_hid {
-	struct spi_device	*spi;	/* spi device. */
-	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
-
-	struct spi_transfer	input_transfer[2];	/* Transfer buffer for read and write. */
-	struct spi_message	input_message;	/* used to execute a sequence of spi transfers. */
-
-	struct spihid_ops	*ops;
-	struct spi_hid_conf	*conf;
-
-	struct spi_hid_device_descriptor desc;	/* HID device descriptor. */
-	struct spi_hid_output_buf *output;	/* Output buffer. */
-	struct spi_hid_input_buf *input;	/* Input buffer. */
-	struct spi_hid_input_buf *response;	/* Response buffer. */
-
-	u16 response_length;
-	u16 bufsize;
-
-	enum hidspi_power_state power_state;
-
-	u8 reset_attempts;	/* The number of reset attempts. */
-
-	unsigned long flags;	/* device flags. */
-
-	struct work_struct reset_work;
-
-	/* Control lock to ensure complete output transaction. */
-	struct mutex output_lock;
-	/* Power lock to make sure one power state change at a time. */
-	struct mutex power_lock;
-	/* I/O lock to prevent concurrent output writes during the input read. */
-	struct mutex io_lock;
-
-	struct completion output_done;
-
-	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
-	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
-
-	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
-
-	u32 regulator_error_count;
-	int regulator_last_error;
-	u32 bus_error_count;
-	int bus_last_error;
-	u32 dir_count;	/* device initiated reset count. */
-};
-
 static struct hid_ll_driver spi_hid_ll_driver;
 
 static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
new file mode 100644
index 000000000000..61b35a4a4180
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ */
+
+#include <linux/hid-over-spi.h>
+#include <linux/spi/spi.h>
+
+/* Protocol message size constants */
+#define SPI_HID_READ_APPROVAL_LEN		5
+#define SPI_HID_OUTPUT_HEADER_LEN		8
+
+/* Raw input buffer with data from the bus */
+struct spi_hid_input_buf {
+	u8 header[HIDSPI_INPUT_HEADER_SIZE];
+	u8 body[HIDSPI_INPUT_BODY_HEADER_SIZE];
+	u8 content[];
+};
+
+/* Raw output report buffer to be put on the bus */
+struct spi_hid_output_buf {
+	u8 header[SPI_HID_OUTPUT_HEADER_LEN];
+	u8 content[];
+};
+
+/* Processed data from a device descriptor */
+struct spi_hid_device_descriptor {
+	u16 hid_version;
+	u16 report_descriptor_length;
+	u16 max_input_length;
+	u16 max_output_length;
+	u16 max_fragment_length;
+	u16 vendor_id;
+	u16 product_id;
+	u16 version_id;
+	u8 no_output_report_ack;
+};
+
+/* Driver context */
+struct spi_hid {
+	struct spi_device	*spi;	/* spi device. */
+	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
+
+	struct spi_transfer	input_transfer[2];	/* Transfer buffer for read and write. */
+	struct spi_message	input_message;	/* used to execute a sequence of spi transfers. */
+
+	struct spihid_ops	*ops;
+	struct spi_hid_conf	*conf;
+
+	struct spi_hid_device_descriptor desc;	/* HID device descriptor. */
+	struct spi_hid_output_buf *output;	/* Output buffer. */
+	struct spi_hid_input_buf *input;	/* Input buffer. */
+	struct spi_hid_input_buf *response;	/* Response buffer. */
+
+	u16 response_length;
+	u16 bufsize;
+
+	enum hidspi_power_state power_state;
+
+	u8 reset_attempts;	/* The number of reset attempts. */
+
+	unsigned long flags;	/* device flags. */
+
+	struct work_struct reset_work;
+
+	/* Control lock to ensure complete output transaction. */
+	struct mutex output_lock;
+	/* Power lock to make sure one power state change at a time. */
+	struct mutex power_lock;
+	/* I/O lock to prevent concurrent output writes during the input read. */
+	struct mutex io_lock;
+
+	struct completion output_done;
+
+	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
+	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
+
+	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
+
+	u32 regulator_error_count;
+	int regulator_last_error;
+	u32 bus_error_count;
+	int bus_last_error;
+	u32 dir_count;		/* device initiated reset count. */
+};
diff --git a/include/trace/events/spi_hid.h b/include/trace/events/spi_hid.h
new file mode 100644
index 000000000000..e9a579b3806c
--- /dev/null
+++ b/include/trace/events/spi_hid.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spi_hid
+
+#if !defined(_SPI_HID_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SPI_HID_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(spi_hid_transfer,
+	TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		 const void *rx_buf, u16 rx_len, int ret),
+
+	TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, ret)
+		__dynamic_array(u8, rx_buf, rx_len)
+		__dynamic_array(u8, tx_buf, tx_len)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->ret = ret;
+
+		memcpy(__get_dynamic_array(tx_buf), tx_buf, tx_len);
+		memcpy(__get_dynamic_array(rx_buf), rx_buf, rx_len);
+	),
+
+	TP_printk("spi%d.%d: len=%d tx=[%*phD] rx=[%*phD] --> %d",
+		  __entry->bus_num, __entry->chip_select,
+		  __get_dynamic_array_len(tx_buf) + __get_dynamic_array_len(rx_buf),
+		  __get_dynamic_array_len(tx_buf), __get_dynamic_array(tx_buf),
+		  __get_dynamic_array_len(rx_buf), __get_dynamic_array(rx_buf),
+		  __entry->ret)
+);
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_sync,
+	     TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		      const void *rx_buf, u16 rx_len, int ret),
+	     TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret));
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_header_complete,
+	     TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		      const void *rx_buf, u16 rx_len, int ret),
+	     TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret));
+
+DEFINE_EVENT(spi_hid_transfer, spi_hid_input_body_complete,
+	     TP_PROTO(struct spi_hid *shid, const void *tx_buf, int tx_len,
+		      const void *rx_buf, u16 rx_len, int ret),
+	     TP_ARGS(shid, tx_buf, tx_len, rx_buf, rx_len, ret));
+
+DECLARE_EVENT_CLASS(spi_hid_irq,
+	TP_PROTO(struct spi_hid *shid, int irq),
+
+	TP_ARGS(shid, irq),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, irq)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->irq = irq;
+	),
+
+	TP_printk("spi%d.%d: IRQ %d",
+		  __entry->bus_num, __entry->chip_select, __entry->irq)
+);
+
+DEFINE_EVENT(spi_hid_irq, spi_hid_dev_irq,
+	     TP_PROTO(struct spi_hid *shid, int irq), TP_ARGS(shid, irq));
+
+DECLARE_EVENT_CLASS(spi_hid,
+	TP_PROTO(struct spi_hid *shid),
+
+	TP_ARGS(shid),
+
+	TP_STRUCT__entry(
+		__field(int, bus_num)
+		__field(int, chip_select)
+		__field(int, power_state)
+		__field(u32, flags)
+
+		__field(int, vendor_id)
+		__field(int, product_id)
+		__field(int, max_input_length)
+		__field(int, max_output_length)
+		__field(u16, hid_version)
+		__field(u16, report_descriptor_length)
+		__field(u16, version_id)
+	),
+
+	TP_fast_assign(
+		__entry->bus_num = shid->spi->controller->bus_num;
+		__entry->chip_select = shid->spi->chip_select;
+		__entry->power_state = shid->power_state;
+		__entry->flags = shid->flags;
+
+		__entry->vendor_id = shid->desc.vendor_id;
+		__entry->product_id = shid->desc.product_id;
+		__entry->max_input_length = shid->desc.max_input_length;
+		__entry->max_output_length = shid->desc.max_output_length;
+		__entry->hid_version = shid->desc.hid_version;
+		__entry->report_descriptor_length =
+					shid->desc.report_descriptor_length;
+		__entry->version_id = shid->desc.version_id;
+	),
+
+	TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state p:%d len i:%d o:%d r:%d flags 0x%08x",
+		  __entry->bus_num, __entry->chip_select,
+		  __entry->vendor_id, __entry->product_id, __entry->version_id,
+		  __entry->hid_version >> 8, __entry->hid_version & 0xff,
+		  __entry->power_state,	__entry->max_input_length,
+		  __entry->max_output_length, __entry->report_descriptor_length,
+		  __entry->flags)
+);
+
+DEFINE_EVENT(spi_hid, spi_hid_header_transfer, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_process_input_report,
+	     TP_PROTO(struct spi_hid *shid), TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_input_report_handler,
+	     TP_PROTO(struct spi_hid *shid), TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_reset_response, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_create_device, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_refresh_device, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_response_handler, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+DEFINE_EVENT(spi_hid, spi_hid_error_handler, TP_PROTO(struct spi_hid *shid),
+	     TP_ARGS(shid));
+
+#endif /* _SPI_HID_TRACE_H */
+
+#include <trace/define_trace.h>

-- 
2.53.0.983.g0bb29b3bc5-goog

